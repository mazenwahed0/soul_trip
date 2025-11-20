// hive_helper.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:soul_trip/core/model/user_model/user_model.dart';
import 'package:soul_trip/core/utils/constant.dart';

class UserHiveHelper {
  // Singleton instance
  static final UserHiveHelper _instance = UserHiveHelper._internal();

  // Private constructor
  UserHiveHelper._internal();

  // Factory constructor to return the same instance
  factory UserHiveHelper() => _instance;

  // تهيئة Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    // تسجيل Adapter لـ UserModel
    if (!Hive.isAdapterRegistered(0)) {
      //Hive.registerAdapter(UserModelAdapter());
    }
    // فتح الصندوق (Box)
    await Hive.openBox<UserModel>(ConstantVariable.userBox);
  }

  // حفظ UserModel في Hive
  Future<void> saveUser(UserModel user) async {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    await box.put(ConstantVariable.uId, user);
  }

  // استرجاع UserModel من Hive
  static UserModel? getUser(String key) {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    return box.get(key);
  }

  // استرجاع كل المستخدمين
  List<UserModel> getAllUsers() {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    return box.values.toList();
  }

  // حذف مستخدم
  Future<void> deleteUser(String key) async {
    final box = Hive.box<UserModel>(ConstantVariable.userBox);
    await box.delete(key);
  }

  // إغلاق Hive (اختياري، يمكن استدعاؤه عند الخروج)
  Future<void> close() async {
    await Hive.close();
  }
}
