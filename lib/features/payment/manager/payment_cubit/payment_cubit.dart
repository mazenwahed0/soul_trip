import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/payment/data/models/card_model.dart';
import 'package:soul_trip/features/payment/data/repository/payment_repository.dart';
import 'package:soul_trip/features/payment/manager/payment_cubit/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _repository;

  PaymentCubit(this._repository) : super(PaymentState());

  void selectPaymentMethod(int index) {
    emit(state.copyWith(selectedPaymentMethodIndex: index));
  }

  Future<void> loadSavedCards(String userId) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    final result = await _repository.getCards(userId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (cards) => emit(
        state.copyWith(status: PaymentStatus.success, savedCards: cards),
      ),
    );
  }

  Future<void> addCard(CardModel card) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    final result = await _repository.addCard(card);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (_) {
        loadSavedCards(card.userId);
      },
    );
  }

  Future<void> deleteCard(String userId, String cardId) async {
    emit(state.copyWith(status: PaymentStatus.loading));
    final result = await _repository.deleteCard(userId, cardId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: PaymentStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (_) {
        loadSavedCards(userId);
      },
    );
  }
}
