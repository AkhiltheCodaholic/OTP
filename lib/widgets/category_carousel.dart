import 'dart:ffi';

import 'package:ecommerce/widgets/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryCarousel extends StatelessWidget {
  final List<Category> categories;
  const CategoryCarousel({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0,),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15),
            itemCount: categories.length,
            itemBuilder: (context, index){
              return Center(
                child: CategoryCard(
                  category: categories[index],
                ),
              );
            },
          );
  }
}
