import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soul_trip/features/experts/data/models/expert_model.dart';

class ExpertsRepository {
  final FirebaseFirestore firestore;

  ExpertsRepository({required this.firestore});

  Stream<List<ExpertModel>> getAllExperts() {
    return firestore
        .collection('experts')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ExpertModel.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  Stream<ExpertModel> getExpertById(String expertId) {
    return firestore
        .collection('experts')
        .doc(expertId)
        .snapshots()
        .map((doc) => ExpertModel.fromMap(doc.data()!, doc.id));
  }
}
