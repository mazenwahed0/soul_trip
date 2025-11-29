import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/user_model/user_model.dart';
import '../../../profile/data/user/user_repository.dart';
import '../../data/authentication_repository.dart';
import 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authRepo;
  final UserRepository _userRepo;

  SignupCubit(this._authRepo, this._userRepo) : super(SignupInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  void togglePasswordVisibility() {
    isPasswordHidden = !isPasswordHidden;
    emit(SignupUpdateUI());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    emit(SignupUpdateUI());
  }

  Future<void> signup() async {
    if (!formKey.currentState!.validate()) return;

    if (passwordController.text != confirmPasswordController.text) {
      emit(const SignupFailure("Passwords do not match"));
      return;
    }

    emit(SignupLoading());

    // 1. Register User in Firebase Auth
    final registerResult = await _authRepo.registerWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    await registerResult.fold(
      (failure) async => emit(SignupFailure(failure.message)),
      (userCredential) async {
        // 2. Create User Model
        final email = emailController.text.trim();
        final nameParts = UserModel.namePartsFromEmail(email);

        final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts[1],
          email: email,
          phoneNumber: '',
          profilePicture: '',
        );

        // 3. Save User to Firestore (Using Fold, NO Try-Catch)
        final saveResult = await _userRepo.saveUserRecord(newUser);

        await saveResult.fold(
          (failure) async {
            // If saving to Firestore fails, we should tell the user
            emit(SignupFailure("Failed to create profile: ${failure.message}"));
          },
          (_) async {
            // 4. Send Email Verification (Only if Firestore save was successful)
            final verificationResult = await _authRepo.sendEmailVerification();

            verificationResult.fold(
              (failure) => emit(
                SignupFailure(
                  "Account created but verification failed: ${failure.message}",
                ),
              ),
              (_) async {
                // Success
                await _authRepo.logout();
                emit(SignupSuccess());
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
