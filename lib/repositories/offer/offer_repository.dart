import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/offer_model.dart';
import 'base_offer_repository.dart';

class OfferRepository extends BaseOfferRepository{
  final FirebaseFirestore _firebaseFirestore;
  OfferRepository({FirebaseFirestore? firebaseFirestore})
      :_firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Offer>> getAllOffer() {
    return _firebaseFirestore
        .collection('offers')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Offer.fromSnapshot(doc)).toList();
    });
  }


}