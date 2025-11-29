import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../core/errors/exceptions/exports.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/repositories/keys.dart';
import '../../../../core/repositories/storage/cloudinary_service.dart';
import '../../../../core/utils/helper_functions.dart';
import '../../../onboarding/data/onboarding_model.dart';

class DataUploadRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CloudinaryService _cloudinaryService;

  DataUploadRepository(this._cloudinaryService);

  Future<Either<Failure, String>> uploadOnboardingData() async {
    try {
      final collectionRef = _db.collection(Keys.onBoardingCollection);

      // -- Clear Existing Data
      final existingDocs = await collectionRef.get();
      for (var doc in existingDocs.docs) {
        await doc.reference.delete();
      }

      final dataList = OnboardingModel.list;

      for (var item in dataList) {
        // 1. Convert Asset to File
        File imageFile = await CHelperFunctions.assetToFile(item.imageUrl);

        // 2. Upload to Cloudinary
        dio.Response response = await _cloudinaryService.uploadImage(
          imageFile,
          Keys.onBoardingFolder,
        );

        if (response.statusCode == 200) {
          final imageUrl = response.data['secure_url'];

          // 3. Prepare Data with new Cloud URL
          final Map<String, dynamic> json = item.toJson();
          json['image'] = imageUrl;

          // 4. Save to Firestore
          await _db.collection(Keys.onBoardingCollection).add(json);

          print('Onboarding Item Uploaded: ${item.title}');
        } else {
          return Left(
            ServerFailure('Failed to upload image for ${item.title}'),
          );
        }
      }
      return const Right('Onboarding data uploaded successfully!');
    } on FirebaseException catch (e) {
      return Left(ServerFailure(CFirebaseException(e.code).message));
    } on FormatException catch (_) {
      return Left(AuthFailure(const CFormatException().message));
    } catch (e) {
      return Left(ServerFailure('Something went wrong. Please try again.'));
    }
  }
}
