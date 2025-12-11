enum AddCardStatus { initial, loading, success, failure }

class AddCardState {
  final AddCardStatus status;
  final String errorMessage;

  const AddCardState({
    this.status = AddCardStatus.initial,
    this.errorMessage = '',
  });

  AddCardState copyWith({AddCardStatus? status, String? errorMessage}) {
    return AddCardState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
