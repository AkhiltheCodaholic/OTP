import 'package:ecommerce/models/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final double widthFactor;
  final double leftPosition;
  const CategoryCard({
    Key? key,
    required this.category,
    this.widthFactor = 2.4,
    this.leftPosition= 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    return InkWell(
      onTap: (){
          Navigator.pushNamed(context, '/catalog', arguments: category);
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / widthFactor,
            child: Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 10.0),
            child: Text(
                category.name,
                style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black)
            ),
          ),
        ],
      ),
    );
  }
}
