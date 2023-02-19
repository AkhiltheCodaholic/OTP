import 'package:ecommerce/blocs/auth/auth_bloc.dart';
import 'package:ecommerce/repositories/user/user_repository.dart';
import 'package:ecommerce/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/profile/profile_bloc.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../widgets/custom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) =>
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              authBloc: context.read<AuthBloc>(),
              userRepository: context.read<UserRepository>(),
            )..add(LoadProfile(context.read<AuthBloc>().state.authUser,
            ),
            ),
            child: ProfileScreen(),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile'),
      bottomNavigationBar: CustomNavBar(screen: routeName),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthRepository>().signOut();
                },
                child: Text('Sign Out'),
              ),
            );
          }
          if (state is ProfileUnauthenticated) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'You\'re not logged in.',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    primary: Colors.black,
                    fixedSize: Size(200, 40),
                  ),
                  child: Text(
                      'Login',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    primary: Colors.white,
                    fixedSize: Size(200, 40),
                  ),
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.headline3
                  ),
                ),
              ],
            );
          } else {
            return Text('Something Went Wrong');
          }
        },
      ),
    );
  }
}
