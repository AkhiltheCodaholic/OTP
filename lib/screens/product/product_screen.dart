import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/models/wishlist_model.dart';
import 'package:ecommerce/widgets/hero_carousel_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/product/product_bloc.dart';
import '../../blocs/wishlist/wishlist_bloc.dart';
import '../../models/product_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_navbar.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
    required this.product
  }) : super(key: key);

  static const String routeName = '/product';

  static Route route({required Product product}){
    return MaterialPageRoute(
        builder: (_) => ProductScreen(product: product),
        settings: RouteSettings(name: routeName)
    );
  }

  final Product product;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar:
      BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            IconButton(icon: Icon(Icons.share, color: Colors.white,), onPressed: (){}),
            BlocBuilder<WishlistBloc, WishlistState>(
  builder: (context, state) {
    return IconButton(
                icon: Icon(Icons.favorite, color: Colors.white,),
                onPressed: (){
                  context
                      .read<WishlistBloc>()
                      .add(AddProductToWishlist(product));

                  final snackBar = SnackBar(
                      content: Text("Added to your Wishlist!!"));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
            );
  },
),
            BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.white),
              onPressed: (){
                context.read<CartBloc>().add(AddProduct(product));
                Navigator.pushNamed(context, '/cart');

                final snackBar = SnackBar(
                    content: Text("Added to your Cart!!"));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text(
                'ADD TO CART',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
  },
),
          ],)
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
  builder: (context, state) {
    if(state is ProductLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if(state is ProductLoaded) {
      return ListView(
        children: [ CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.5,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
          ),
          items: state.products
              .map(
                  (category) => HeroCarouselCard(
                    product: product,),
          ).toList(),
        ),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    color: Colors.black.withAlpha(50),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 10,
                    height: 50,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(product.name,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                          Text('\₹${product.price}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Product Information', style: Theme
                  .of(context)
                  .textTheme
                  .headline3,),
              children: [
                ListTile(
                  title: Text(
                    product.description ?? '',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: Text('Delivery Information', style: Theme
                  .of(context)
                  .textTheme
                  .headline3,),
              children: [
                ListTile(
                  title: Text(
                    'Delivery Information',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    else{return Text('Something Went Wrong');}
  },

),
    );
  }
}