

import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  Widget buildListTile(String title, IconData icon,final Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.orange,
            fontSize: 24,
            fontFamily: 'Avenir',
            fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () => tapHandler(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
           padding:const  EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
                'Welcome!',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Divider(thickness: 3,),
          SizedBox(height: 20,),
          buildListTile('Categories', Icons.category, (){
            Navigator.pushNamed(context, '/category');
          }
          ),
          Divider(thickness: 3,),
          SizedBox(height: 20,),
          buildListTile('My Wishlist', Icons.favorite, (){
            Navigator.pushNamed(context, '/wishlist');
          }
          ),
          Divider(thickness: 3,),
          SizedBox(height: 20,),
          buildListTile('Cart', Icons.shopping_cart, (){
            Navigator.pushNamed(context, '/cart');
          }
          ),
        ],
      ),
    );
  }
}
