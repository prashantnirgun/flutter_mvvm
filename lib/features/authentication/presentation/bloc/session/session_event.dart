import 'package:bpp/features/authentication/data/models/user_model.dart';

abstract class SessionEvent {}

class LoadUserFromPrefsEvent extends SessionEvent {}

class LogoutUserEvent extends SessionEvent {}

class FetchUserEvent extends SessionEvent {
  final UserModel? user;
  FetchUserEvent({this.user});
}
