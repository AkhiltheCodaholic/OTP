import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/widgets/category_carousel.dart';
import 'package:ecommerce/widgets/main_drawer.dart';
import 'package:ecommerce/widgets/product_carousel.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/category/category_bloc.dart';
import '../../blocs/offers/offers_bloc.dart';
import '../../blocs/product/product_bloc.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_navbar.dart';
import '../../widgets/hero_carousel_card.dart';
import '../../widgets/hero_carousel_cardoffer.dart';
import '../../widgets/product_card.dart';
import '../../widgets/section_title.dart';


class HomeScreen extends StatelessWidget {

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(), settings: RouteSettings(name: routeName),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'OTP'),
      drawer: MainDrawer(),
      bottomNavigationBar: CustomNavBar(screen: routeName,),
      body: ListView(
          children: [Column(
            children: [
              SectionTile(title: 'CATEGORIES'),
              Container(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CategoryLoaded) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 1.5,
                          viewportFraction: 0.9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlay: true,
                        ),
                        items: state.categories
                            .map((category) =>
                            HeroCarouselCard(
                                category: category)).toList(),
                      );
                    }
                    else {
                      return Text("Someting Went Wrong");
                    }
                  },
                ),),
              SectionTile(title: 'RECOMMENDED'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if(state is ProductLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is ProductLoaded){
                    return ProductCarousel(
                        products: state.products
                            .where((product) => product.isRecommended)
                            .toList(),);
                  }
                  else{return Text('Something Went Wrong');
                  }
                },
              ),
              SectionTile(title: 'MOST POPULAR'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if(state is ProductLoading){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if(state is ProductLoaded){
                    return ProductCarousel(
                      products: state.products
                          .where((product) => product.isPopular)
                          .toList(),
                    );
                  }
                  else{return Text('Something Went Wrong');
                  }
                },
              ),
              SectionTile(title: 'OFFERS'),
              Container(
                child: BlocBuilder<OfferBloc, OfferState>(
                  builder: (context, state) {
                    if (state is OfferLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is OfferLoaded) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 1.5,
                          viewportFraction: 0.9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlay: true,
                        ),
                        items: state.offers
                            .map((offer) =>
                            HeroCarouselCardoffer(
                                offer: offer)).toList(),
                      );
                    }
                    else {
                      return Text("Someting Went Wrong");
                    }
                  },
                ),),
              SectionTile(title: 'Our Products'),
              Container(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state){
                      if (state is CategoryLoading){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is CategoryLoaded){
                        return SizedBox(
                          height: 500,
                          child: CategoryCarousel(categories: state.categories.toList()),
                        );
                      }
                      else{
                        return Text('Something Went Wrong');
                      }
                    }
                ),
              ),

              //ProductCard(product: Product.products[0])
            ],
          ),
          ]
      ),
    );
  }
}





















