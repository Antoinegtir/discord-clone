import 'package:discord/model/user.model.dart';

abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final User user;
  UserLoggedIn(this.user);
}

class UserLoggedOut extends AuthEvent {}
