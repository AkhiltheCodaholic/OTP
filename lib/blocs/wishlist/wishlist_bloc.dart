import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/models/wishlist_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../models/product_model.dart';
import '../../repositories/local_storage/local_storage_repository.dart';


part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;
  WishlistBloc({
    required LocalStorageRepository localStorageRepository,
}) :
      _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<LoadWishList>(_onLoadWishlist);
    on<AddProductToWishlist>(_onAddProductToWishlist);
    on<RemoveProductFromWishlist>(_onRemoveProductFromWishlist);
  }

  void _onLoadWishlist(
      LoadWishList event,
      Emitter<WishlistState> emit
      ) async {

    emit(WishlistLoading(),);

    try {
      Box box=await _localStorageRepository.openBox();
      List<Product> products = _localStorageRepository.getWishlist(box);
      await Future<void>.delayed(Duration(seconds: 1));
      emit(
        WishlistLoaded(
          wishlist: Wishlist(products: products),
      ),
      );
    } catch (_) {
      emit(WishlistError());
    }
  }

  Future<void> _onAddProductToWishlist(
      AddProductToWishlist event,
      Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.addProductToWishlist(box, event.product);
        emit(WishlistLoaded(
          wishlist:
          Wishlist(
            products:
            List.from((this.state as WishlistLoaded).wishlist.products)
          ..add(event.product),),),);
      } on Exception {
        emit(WishlistError());
      }
    }
  }

  void _onRemoveProductFromWishlist(
      RemoveProductFromWishlist event,
      Emitter<WishlistState> emit) async {
    final state = this.state;
    if (state is WishlistLoaded) {
      try {
        Box box = await _localStorageRepository.openBox();
        _localStorageRepository.removeProductFromWishList(box, event.product);

        emit(WishlistLoaded(
          wishlist:
          Wishlist(
            products:
            List.from((this.state as WishlistLoaded).wishlist.products)
              ..remove(event.product),),),);
      } on Exception {
        emit(WishlistError());
      }
    }
  }


}


