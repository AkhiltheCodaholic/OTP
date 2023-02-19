import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/offer_model.dart';
import '../../repositories/offer/offer_repository.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final OfferRepository _offerRepository;
  StreamSubscription? _offerSubscription;

  OfferBloc({required OfferRepository offerRepository,})
      : _offerRepository = offerRepository,
        super(OfferLoading()) {
    on<LoadOffers>(_onLoadOffers);
    on<UpdateOffers>(_onUpdateOffers);
  }

  void _onLoadOffers(event, Emitter<OfferState> emit) {
    _offerSubscription?.cancel();
    _offerSubscription = _offerRepository
        .getAllOffer()
        .listen((offers) =>
        add(
          UpdateOffers(offers),
        ),
    );
  }

  void _onUpdateOffers(event, Emitter<OfferState> emit) {
    emit(OfferLoaded(offers: event.offers),);
  }

}