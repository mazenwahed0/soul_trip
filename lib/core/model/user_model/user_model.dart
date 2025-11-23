import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../../func/format_phone.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  String phoneNumber;

  @HiveField(5)
  String profilePicture;

  @HiveField(6)
  String publicId;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    this.publicId = '',
  });

  /// [GenerateName] Extract First & Last Name from Email
  /// Example: "john.doe@gmail.com" -> ["john", "doe"]
  /// Example: "ahmed@gmail.com" -> ["ahmed", ""]
  static List<String> namePartsFromEmail(String email) {
    if (email.isEmpty) return ["", ""];

    final nameFromEmail = email.split('@')[0]; // "john.doe"
    final parts = nameFromEmail.split('.'); // ["john", "doe"]

    final firstName = parts[0];
    final lastName = parts.length > 1 ? parts[1] : "";

    return [firstName, lastName];
  }

  /// Function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Static function to format phone number.
  String get formattedPhoneNo => formatEgyptianPhoneNumber(phoneNumber);

  /// Static function to split full name into first name and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// static function to create an empty user model
  static UserModel empty() => UserModel(
    id: "",
    firstName: "",
    lastName: "",
    email: "",
    phoneNumber: "",
    profilePicture: "",
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'publicId': publicId,
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
        publicId: data['publicId'],
      );
    } else {
      return UserModel.empty();
    }
  }
}
