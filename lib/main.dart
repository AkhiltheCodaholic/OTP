import 'package:ecommerce/blocs/cart/cart_bloc.dart';
import 'package:ecommerce/blocs/offers/offers_bloc.dart';
import 'package:ecommerce/blocs/payment/payment_bloc.dart';
import 'package:ecommerce/config/app_router.dart';
import 'package:ecommerce/cubits/login/login_cubit.dart';
import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/repositories/auth/auth_repository.dart';
import 'package:ecommerce/repositories/category/category_repository.dart';
import 'package:ecommerce/repositories/checkout/checkout_repository.dart';
import 'package:ecommerce/repositories/local_storage/local_storage_repository.dart';
import 'package:ecommerce/repositories/offer/offer_repository.dart';
import 'package:ecommerce/repositories/product/product_repository.dart';
import 'package:ecommerce/repositories/user/user_repository.dart';
import 'package:ecommerce/screens/checkout/checkout_screen.dart';
import 'package:ecommerce/screens/order_confirmation/order_confirmation_screen.dart';
import 'package:ecommerce/screens/payment_selection/payment_selection_screen.dart';
import 'package:ecommerce/screens/splash/splash_screen.dart';
import 'package:ecommerce/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/category/category_bloc.dart';
import 'blocs/checkout/checkout_bloc.dart';
import 'blocs/product/product_bloc.dart';
import 'blocs/wishlist/wishlist_bloc.dart';
import 'config/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cubits/signup/signup_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  BlocOverrides.runZoned((){
    runApp(MyApp());
  },
      blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zero To Unicorn',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(

            create: (context) => UserRepository(),
          ),
          RepositoryProvider(
            create: (context) => AuthRepository(userRepository: context.read<UserRepository>()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthBloc(
                userRepository: context.read<UserRepository>(),
                authRepository: context.read<AuthRepository>(),
              ),
            ),
            BlocProvider(
              create: (_) => CartBloc()..add(LoadCart()),
            ),
            BlocProvider(
              create: (_) => PaymentBloc()..add(LoadPaymentMethod()),
            ),
            BlocProvider(
              create: (context) => CheckoutBloc(
                cartBloc: context.read<CartBloc>(),
                paymentBloc: context.read<PaymentBloc>(),
                checkoutRepository: CheckoutRepository(),
              ),
            ),
            BlocProvider(
              create: (_) => WishlistBloc(
                localStorageRepository: LocalStorageRepository(),
              )..add(LoadWishList()),
            ),
            BlocProvider(
              create: (_) => CategoryBloc(
                categoryRepository: CategoryRepository(),
              )..add(
                LoadCategories(),
              ),
            ),
            BlocProvider(create: (_) => OfferBloc(
              offerRepository: OfferRepository(),
            )..add(
              LoadOffers(),
            ),
            ),
            BlocProvider(
              create: (_) => ProductBloc(
                productRepository: ProductRepository(),
              )..add(LoadProducts()),
            ),
            BlocProvider(create: (_) => ProductBloc(
              productRepository: ProductRepository(),
            )..add(LoadProducts()),
            ),
            BlocProvider(
                create: (context) => LoginCubit(
                    authRepository: context.read<AuthRepository>(),
                ),
            ),
            BlocProvider(
              create: (context) => SignupCubit(
                authRepository: context.read<AuthRepository>(),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'Zero To Unicorn',
            debugShowCheckedModeBanner: false,
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: SplashScreen.routeName,
          ),
        ),
      ),
    );
  }
}









