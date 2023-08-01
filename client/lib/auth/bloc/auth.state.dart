import 'package:equatable/equatable.dart';

import '../../model/user.model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => <String>[];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);

  @override
  List<Object?> get props => <Object>[user];
}

class Unauthenticated extends AuthState {}
