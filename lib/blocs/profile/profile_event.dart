part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable{
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final auth.User? authUser;

  LoadProfile(this.authUser);

  @override
  List<Object?> get props => [authUser];
}

class UpdateProfile extends ProfileEvent {
  final User user;

  UpdateProfile(this.user);

  @override
  List<Object?> get props => [user];
}