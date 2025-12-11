import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soul_trip/features/payment/data/models/card_model.dart';
import 'package:soul_trip/core/errors/failures.dart';

class PaymentRepository {
  final FirebaseFirestore _firestore;

  PaymentRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<Either<Failure, void>> addCard(CardModel card) async {
    try {
      await _firestore
          .collection('users')
          .doc(card.userId)
          .collection('cards')
          .doc(card.id)
          .set(card.toMap());
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<CardModel>>> getCards(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cards')
          .get();

      final cards = querySnapshot.docs
          .map((doc) => CardModel.fromMap(doc.data()))
          .toList();

      return Right(cards);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteCard(String userId, String cardId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cards')
          .doc(cardId)
          .delete();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
