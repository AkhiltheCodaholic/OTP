part of 'offers_bloc.dart';

abstract class OfferState extends Equatable{

  @override
  List<Object> get props => [];
}

class OfferLoading extends OfferState {}

class OfferLoaded extends OfferState {
  final List<Offer> offers;
  OfferLoaded({this.offers = const <Offer>[]});

  @override
  List<Object> get props => [offers];
}

