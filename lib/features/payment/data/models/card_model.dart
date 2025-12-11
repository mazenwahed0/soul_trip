class CardModel {
  final String id;
  final String cardName;
  final String cardNumber;
  final String cardIcon;
  final String userId;
  final String expiryDate;
  final String cvv;

  CardModel({
    required this.id,
    required this.cardName,
    required this.cardNumber,
    required this.cardIcon,
    required this.userId,
    required this.expiryDate,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cardName': cardName,
      'cardNumber': cardNumber,
      'cardIcon': cardIcon,
      'userId': userId,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      cardName: map['cardName'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      cardIcon: map['cardIcon'] ?? '',
      userId: map['userId'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      cvv: map['cvv'] ?? '',
    );
  }

  static CardModel empty() {
    return CardModel(
      id: '',
      cardName: '',
      cardNumber: '',
      cardIcon: '',
      userId: '',
      expiryDate: '',
      cvv: '',
    );
  }
}
