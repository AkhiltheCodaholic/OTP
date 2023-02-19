import 'package:ecommerce/widgets/custom_appbar.dart';
import 'package:ecommerce/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';
import '../../widgets/order_summary.dart';
import '../../widgets/product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String routeName = '/cart';

  static Route route(){
    return MaterialPageRoute(builder: (_) => CartScreen(),settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Cart'),
      bottomNavigationBar: CustomNavBar(screen: routeName,),
      //BottomAppBar(
        //color: Colors.black,
        //child: Container(
            //height: 70,
            //child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //children: [

                //ElevatedButton(
                  //style: ElevatedButton.styleFrom(primary: Colors.white),
                  //onPressed: (){
                   // Navigator.pushNamed(context, '/checkout');
                 // },
                 // child: Text(
                    //'GO TO CHECKOUT',
                   // style: Theme.of(context).textTheme.headline5,
                  //),
                //),
              //],)
        //),
      //),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          }
          if (state is CartLoaded) {
            Map cart = state.cart.productQuantity(state.cart.products);
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.cart.freeDeliveryString,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add More Items',
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 450,
                    child: ListView.builder(
                      itemCount: cart.keys.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard.cart(
                          product: cart.keys.elementAt(index),
                          quantity: cart.values.elementAt(index),
                        );
                      },
                    ),
                  ),
                  OrderSummary(),
                ],
              ),
            );
          }
          return Text('Something went wrong');
        },
      ),
    );
  }
}


