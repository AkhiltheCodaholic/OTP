import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/widgets/custom_appbar.dart';
import 'package:ecommerce/widgets/custom_navbar.dart';
import 'package:ecommerce/widgets/order_summary.dart';
import 'package:ecommerce/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class OrderConfirmation extends StatelessWidget {
  static const String routeName = '/order-confirmation';

  static Route route(){
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OrderConfirmation(),
    );
  }
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Confirm Order',),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [Container(
                color: Colors.black,
                width: double.infinity,
                height: 300,
              ),
                Positioned(
                  left: (MediaQuery.of(context).size.width-100)/2,
                    top: 125,
                    child: SvgPicture.asset('assets/svgs/garlands.svg'),
                ),
                Positioned(
                  top: 250,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Your order is complete!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                ),
        ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 10,),
                  Text(
                      'Thank you for purchasing on OTP.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'ORDER CODE: #k321-ekd3',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  OrderSummary(),
                  Text(
                    'ORDER DETAILS',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Divider(thickness: 2,),
                  SizedBox(height: 5,),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ProductCard.summary(
                        product: Product.products[0],
                        quantity: 2,
                      ),
                      ProductCard.summary(
                        product: Product.products[1],
                        quantity: 2,
                      ),
                ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



