import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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

  /// [VERCEL] - OTP Forgot Password via Email Address
  /// [Custom] - Send OTP
  Future<Either<Failure, void>> sendOtpEmail(String email) async {
    // Note: NO (_guard) here to handle HTTP errors specifically
    try {
      final response = await http.post(
        Uri.parse('https://soul-trip-backend.vercel.app/api/send-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        // Decode the error message from the server
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Left(ServerFailure(data['error'] ?? 'Failed to send OTP'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// [Custom] - Verify OTP
  Future<Either<Failure, bool>> verifyOtp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('https://soul-trip-backend.vercel.app/api/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // Return a failure so the UI knows it's invalid
        return Left(ServerFailure(data['error'] ?? 'Invalid OTP'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  /// [Custom] - Verify OTP & Reset Password
  Future<Either<Failure, void>> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://soul-trip-backend.vercel.app/api/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Left(ServerFailure(data['error'] ?? 'Failed to reset password'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
