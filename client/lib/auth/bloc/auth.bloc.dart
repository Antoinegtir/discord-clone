import 'package:discord/model/user.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.event.bloc.dart';
import 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final User? user = await _getUserFromPreferences();
    if (user != null) {
      emit(Authenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onUserLoggedIn(
      UserLoggedIn event, Emitter<AuthState> emit) async {
    emit(Authenticated(event.user));
    _saveUserToPreferences(event.user);
  }

  Future<void> _onUserLoggedOut(
      UserLoggedOut event, Emitter<AuthState> emit) async {
    emit(Unauthenticated());
    _clearUserFromPreferences();
  }

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is UserLoggedIn) {
      yield Authenticated(event.user);
      _saveUserToPreferences(event.user);
    } else if (event is UserLoggedOut) {
      yield Unauthenticated();
      _clearUserFromPreferences();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    final User? user = await _getUserFromPreferences();
    if (user != null) {
      yield Authenticated(user);
    } else {
      yield Unauthenticated();
    }
  }

  Future<User?> _getUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('id');
    final String? email = prefs.getString('email');
    final String? username = prefs.getString('username');
    final String? displayName = prefs.getString('displayName');
    final String? birthday = prefs.getString('birthday');
    final String? createdAt = prefs.getString('createdAt');
    final String? profilePic = prefs.getString('profilePic');
    final String? status = prefs.getString('status');
    if (id != null &&
        email != null &&
        displayName != null &&
        birthday != null &&
        status != null &&
        createdAt != null &&
        profilePic != null &&
        username != null) {
      return User(
        id: id,
        email: email,
        username: username,
        displayName: displayName,
        birthday: birthday,
        createdAt: createdAt,
        profilePic: profilePic,
        status: status,
      );
    }
    return null;
  }

  Future<void> _saveUserToPreferences(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('username', user.username);
    await prefs.setString('displayName', user.displayName);
    await prefs.setString('birthday', user.birthday);
    await prefs.setString('profilePic', user.profilePic);
    await prefs.setString('status', user.status);
    await prefs.setString('createdAt', user.createdAt);
  }

  Future<void> _clearUserFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
