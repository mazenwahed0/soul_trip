import 'package:hive_flutter/hive_flutter.dart';

//part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String uid;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String lastName;

  UserModel({
    required this.email,
    required this.uid,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }
}
