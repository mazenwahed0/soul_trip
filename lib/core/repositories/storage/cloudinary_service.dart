import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart' as dio;
import '../api_constants.dart';
import '../keys.dart';

class CloudinaryService {
  final _dio = dio.Dio();

  /// [UploadImage] - Function to upload Image
  Future<dio.Response> uploadImage(
    File image,
    String folderName, {
    String publicId = '',
  }) async {
    try {
      String api = ApiUrls.uploadApi(Keys.cloudName);

      final Map<String, dynamic> data = {
        'upload_preset': Keys.uploadPreset,
        'folder': folderName,
        'file': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      };

      if (publicId.isNotEmpty) {
        data['public_id'] = publicId;
      }

      final formData = dio.FormData.fromMap(data);

      dio.Response response = await _dio.post(api, data: formData);
      return response;
    } catch (e) {
      throw 'Upload Failed: $e';
    }
  }

  /// [DeleteImage] - Function to delete Image
  Future<dio.Response> deleteImage(String publicId) async {
    try {
      String api = ApiUrls.deleteApi(Keys.cloudName);

      int timestamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

      String signatureBase =
          'public_id=$publicId&timestamp=$timestamp${Keys.apiSecret}';
      String signature = sha1.convert(utf8.encode(signatureBase)).toString();

      final formData = dio.FormData.fromMap({
        'public_id': publicId,
        'api_key': Keys.apiKey,
        'timestamp': timestamp,
        'signature': signature,
      });

      return await _dio.post(api, data: formData);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
