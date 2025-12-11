import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soul_trip/features/add_card/logic/add_card_cubit/add_card_state.dart';
import 'package:soul_trip/features/payment/data/models/card_model.dart';
import 'package:soul_trip/features/payment/data/repository/payment_repository.dart';
import 'package:uuid/uuid.dart';

class AddCardCubit extends Cubit<AddCardState> {
  final PaymentRepository _repository;

  AddCardCubit(this._repository) : super(const AddCardState());

  Future<void> addCard({
    required String holderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
    required String userId,
  }) async {
    // Basic Validation
    if (holderName.isEmpty ||
        cardNumber.isEmpty ||
        expiryDate.isEmpty ||
        cvv.isEmpty) {
      emit(
        state.copyWith(
          status: AddCardStatus.failure,
          errorMessage: 'All fields are required',
        ),
      );
      return;
    }

    // 16-Digit Validation
    // Remove any spaces or dashes if present
    final cleanNumber = cardNumber.replaceAll(RegExp(r'\s+'), '');
    if (cleanNumber.length != 16 || int.tryParse(cleanNumber) == null) {
      emit(
        state.copyWith(
          status: AddCardStatus.failure,
          errorMessage: 'Card number must be 16 digits',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AddCardStatus.loading));

    final card = CardModel(
      id: const Uuid().v4(),
      cardName: holderName,
      cardNumber:
          cardNumber, // Store original formatted or clean, user preference. Keeping original input usually better for display if masked.
      cardIcon: 'assets/icons/visa.png', // Default or logic to detect type
      userId: userId,
      expiryDate: expiryDate,
      cvv: cvv,
    );

    final result = await _repository.addCard(card);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AddCardStatus.failure,
          errorMessage: failure.toString(),
        ),
      ),
      (_) => emit(state.copyWith(status: AddCardStatus.success)),
    );
  }
}
