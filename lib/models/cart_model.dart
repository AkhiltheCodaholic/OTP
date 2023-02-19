import 'package:ecommerce/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Cart extends Equatable{

  final List<Product> products;

  const Cart({this.products = const <Product>[]});

  double get subtotal =>
      products.fold(0,(total, current) => total + current.price);

  Map productQuantity(products){
    var quantity = Map();

    products.forEach((product){
      if(!quantity.containsKey(product)){
        quantity[product] = 1;
      }
      else{
        quantity[product] += 1;
      }
    });

    return quantity;
  }


  double total(subtotal,deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }


  double deliveryFee(subtotal) {
    if(subtotal >= 30.0){
      return 0.0;
    }else{
      return 10.0;
    }
  }

  String freeDelivery(subtotal){
    if(subtotal >= 30.0){
      return 'You Have Free Delivery!!';
    }else{
      double missing = 30.0-subtotal;

      return 'Add \₹${missing.toStringAsFixed(2)} for FREE delivery';
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  String get deliveryFeesString => deliveryFee(subtotal).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);


  @override
  List<Object?> get props => [products];}