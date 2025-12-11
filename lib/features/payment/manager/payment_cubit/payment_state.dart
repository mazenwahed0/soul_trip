import 'package:soul_trip/features/payment/data/models/card_model.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState {
  final int selectedPaymentMethodIndex;
  final List<CardModel> savedCards;
  final CardModel? selectedCard;
  final PaymentStatus status;
  final String errorMessage;

  PaymentState({
    this.selectedPaymentMethodIndex = 0,
    this.savedCards = const [],
    this.selectedCard,
    this.status = PaymentStatus.initial,
    this.errorMessage = '',
  });

  PaymentState copyWith({
    int? selectedPaymentMethodIndex,
    List<CardModel>? savedCards,
    CardModel? selectedCard,
    PaymentStatus? status,
    String? errorMessage,
  }) {
    return PaymentState(
      selectedPaymentMethodIndex:
          selectedPaymentMethodIndex ?? this.selectedPaymentMethodIndex,
      savedCards: savedCards ?? this.savedCards,
      selectedCard: selectedCard ?? this.selectedCard,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
