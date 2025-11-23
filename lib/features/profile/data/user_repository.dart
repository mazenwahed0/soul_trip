import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../core/dependency_injection/set_up_dependencies.dart';
import '../../../core/errors/exceptions/exports.dart';
import '../../../core/errors/failures.dart';
import '../../../core/model/user_model/user_model.dart';
import '../../authentication/data/authentication_repository.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AuthenticationRepository _authRepo = getIt<AuthenticationRepository>();

  /// Helper to standardize error handling
  Future<Either<Failure, T>> _guard<T>(Future<T> Function() body) async {
    try {
      final result = await body();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(CFirebaseException(e.code).message));
    } on FormatException catch (_) {
      return const Left(
        ServerFailure('Invalid format. Please check your input.'),
      );
    } on PlatformException catch (e) {
      return Left(ServerFailure(CPlatformException(e.code).message));
    } catch (e) {
      return Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }

  /// Save user data to Firestore
  Future<Either<Failure, void>> saveUserRecord(UserModel user) async {
    return _guard(() async {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    });
  }

  /// Check if user exists by email
  Future<Either<Failure, UserModel?>> checkUserByEmail(String? email) async {
    return _guard(() async {
      final result = await _db
          .collection("Users")
          .where("email", isEqualTo: email)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        return UserModel.fromSnapshot(result.docs.first);
      } else {
        return null;
      }
    });
  }

  /// Fetch user details
  Future<Either<Failure, UserModel>> fetchUserDetails() async {
    return _guard(() async {
      final uid = _authRepo.currentUser?.uid;
      if (uid == null) throw 'User not authenticated';

      final documentSnapshot = await _db.collection("Users").doc(uid).get();

      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    });
  }

  /// Update user data
  Future<Either<Failure, void>> updateUserDetails(UserModel updatedUser) async {
    return _guard(() async {
      await _db
          .collection("Users")
          .doc(updatedUser.id)
          .update(updatedUser.toJson());
    });
  }

  /// Update single field
  Future<Either<Failure, void>> updateSingleField(
    Map<String, dynamic> json,
  ) async {
    return _guard(() async {
      final uid = _authRepo.currentUser?.uid;
      if (uid == null) throw 'User not authenticated';

      await _db.collection("Users").doc(uid).update(json);
    });
  }

  /// Remove user record
  Future<Either<Failure, void>> removeUserRecord(String userId) async {
    return _guard(() async {
      await _db.collection("Users").doc(userId).delete();
    });
  }
}
