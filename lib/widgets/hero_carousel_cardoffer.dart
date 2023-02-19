import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/offer_model.dart';
import '../models/product_model.dart';

class HeroCarouselCardoffer extends StatelessWidget {

  final Offer ? offer;
  final Product ? product;
  const HeroCarouselCardoffer({
    this.offer,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.symmetric(vertical: 20.0,horizontal: 5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                    product == null ? offer!.imageUrl : product!.imageUrl,
                    fit: BoxFit.cover,
                    width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      product == null ? offer!.name : '',
                      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white),),
                  ),
                ),
              ],
            )),
      );

  }
}