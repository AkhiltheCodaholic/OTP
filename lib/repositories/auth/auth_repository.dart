import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/repositories/auth/base_auth_repository.dart';
import 'package:ecommerce/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    required UserRepository userRepository,
  })
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
  _userRepository = userRepository;

  @override
  Future<auth.User?>signUp({
    required User user,
    required String password,
  }) async {
    try {
      _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      ).then((value) => _userRepository.createUser(user.copyWith(id: value.user!.uid),
      ),
      );

    } catch (_) {}
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}