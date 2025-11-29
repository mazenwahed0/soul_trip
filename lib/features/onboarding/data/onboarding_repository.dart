import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import '../../../core/errors/exceptions/exports.dart';
import '../../../core/errors/failures.dart';
import '../../../core/repositories/keys.dart';
import 'onboarding_model.dart';

class OnboardingRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Either<Failure, List<OnboardingModel>>> fetchOnboardingData() async {
    try {
      final snapshot = await _db.collection(Keys.onBoardingCollection).get();

      if (snapshot.docs.isNotEmpty) {
        final list = snapshot.docs
            .map((doc) => OnboardingModel.fromSnapshot(doc))
            .toList();
        return Right(list);
      } else {
        // -- Fallback to local list if DB is empty Or return empty.
        return Right(OnboardingModel.list);
      }
    } on FirebaseException catch (e) {
      return Left(ServerFailure(CFirebaseException(e.code).message));
    } on FormatException catch (_) {
      return Left(ServerFailure(const CFormatException().message));
    } on PlatformException catch (e) {
      return Left(ServerFailure(CPlatformException(e.code).message));
    } catch (e) {
      return Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }
}
