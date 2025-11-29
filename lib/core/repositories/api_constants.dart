class ApiUrls {
  static String uploadApi(String cloudName) =>
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  static String deleteApi(String cloudName) =>
      'https://api.cloudinary.com/v1_1/$cloudName/image/destroy';
}
