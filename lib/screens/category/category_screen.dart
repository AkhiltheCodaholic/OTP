import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/widgets/category_carousel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/category/category_bloc.dart';
import '../../widgets/custom_appbar.dart';

class CategoryScreen extends StatelessWidget {

  static const String routeName = '/category';


  const CategoryScreen({
    Key? key,
  }) : super(key: key);

  static Route route(){
    return MaterialPageRoute(
        builder: (_) => const CategoryScreen(),
        settings: const RouteSettings(name: routeName)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Categories',),
      body: ListView(
        children: [
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
                    height: 600,
                    child: CategoryCarousel(categories: state.categories.toList()),
                  );
                }
                else{
                  return Text('Something Went Wrong');
                }
              }
            ),
          ),
        ],
      )
    );
  }
}
