import '../../models/offer_model.dart';

abstract class BaseOfferRepository{
  Stream<List<Offer>> getAllOffer();
}