part of 'offers_bloc.dart';

abstract class OfferEvent extends Equatable{
  const OfferEvent();

  @override
  List<Object> get props => [];
}

class LoadOffers extends OfferEvent{}

class UpdateOffers extends OfferEvent{
  final List<Offer> offers;

  UpdateOffers(this.offers);

  @override
  List<Object> get props => [offers];
}
