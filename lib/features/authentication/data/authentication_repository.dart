import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/exceptions/exports.dart';
import '../../../core/errors/failures.dart';

class AuthenticationRepository {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  /// Helper to catch exceptions and return Failure
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() body) async {
    try {
      final result = await body();
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(CFirebaseAuthException(e.code).message));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(CFirebaseException(e.code).message));
    } on FormatException catch (_) {
      return Left(AuthFailure(const CFormatException().message));
    } on PlatformException catch (e) {
      return Left(AuthFailure(CPlatformException(e.code).message));
    } catch (e) {
      return Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }

  /// [EmailAuthentication] - LOGIN
  Future<Either<Failure, UserCredential>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _guard(() async {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  /// [EmailAuthentication] - REGISTER
  Future<Either<Failure, UserCredential>> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return _guard(() async {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  /// [GoogleAuthentication] - GOOGLE
  Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User cancelled, strictly speaking this isn't a failure,
        // but in Either pattern we usually treat "no result" as a cancel or specific Failure.
        return const Left(AuthFailure('Google Sign-In cancelled'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return Right(userCredential);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(CFirebaseAuthException(e.code).message));
    } catch (e) {
      return const Left(
        ServerFailure('Google Sign-In failed. Please try again.'),
      );
    }
  }

  /// [EmailAuthentication] - Send Email Verification
  Future<Either<Failure, void>> sendEmailVerification() async {
    return _guard(() async {
      await _auth.currentUser?.sendEmailVerification();
    });
  }

  /// [EmailAuthentication] - Forgot Password
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    return _guard(() async {
      await _auth.sendPasswordResetEmail(email: email);
    });
  }

  /// [Logout] - Email/Password & Google Logout
  Future<Either<Failure, void>> logout() async {
    return _guard(() async {
      await GoogleSignIn().signOut();
      await _auth.signOut();
    });
  }
}
