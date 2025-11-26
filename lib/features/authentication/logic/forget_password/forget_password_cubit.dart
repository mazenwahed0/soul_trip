import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/authentication/data/authentication_repository.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AuthenticationRepository _authRepo;

  ForgetPasswordCubit(this._authRepo) : super(ForgetPasswordInitial());

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> sendResetEmail() async {
    if (!formKey.currentState!.validate()) return;

    emit(ForgetPasswordLoading());

    final result = await _authRepo.sendPasswordResetEmail(
      emailController.text.trim(),
    );

    result.fold(
      (failure) => emit(ForgetPasswordFailure(failure.message)),
      (_) => emit(ForgetPasswordSuccess()),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
