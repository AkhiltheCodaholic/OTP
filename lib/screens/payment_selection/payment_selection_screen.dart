import 'dart:io';

import 'package:ecommerce/models/payment_method_model.dart';
import 'package:ecommerce/widgets/custom_appbar.dart';
import 'package:ecommerce/widgets/custom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

import '../../blocs/payment/payment_bloc.dart';
class PaymentSelection extends StatelessWidget {
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PaymentSelection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Payment Selection'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Platform.isIOS
                    ? RawApplePayButton(
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.inStore,
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                      SelectPaymentMethod(
                          paymentMethod: PaymentMethod.apple_pay),
                    );
                    Navigator.pop(context);
                  },
                )
                    : SizedBox(),
                const SizedBox(height: 10),
                Platform.isAndroid
                    ? RawGooglePayButton(
                  type: GooglePayButtonType.pay,
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                      SelectPaymentMethod(
                          paymentMethod: PaymentMethod.google_pay),
                    );
                    Navigator.pop(context);
                  },
                )
                    : SizedBox(),
                ElevatedButton(
                  onPressed: () {
                    context.read<PaymentBloc>().add(
                      SelectPaymentMethod(
                          paymentMethod: PaymentMethod.credit_card),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Pay with Credit Card'),
                ),
              ],
            );
          } else {
            return Text('Something went wrong');
          }
        },
      ),
    );
  }
}
