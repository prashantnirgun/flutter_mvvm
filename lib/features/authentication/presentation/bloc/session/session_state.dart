import 'package:bpp/features/authentication/data/models/user_model.dart';

enum SessionStatus { unknown, authenticated, unauthenticated }

class SessionState {
  final SessionStatus status;
  final UserModel? user;

  const SessionState({this.status = SessionStatus.unknown, this.user});

  SessionState copyWith({SessionStatus? status, UserModel? user}) {
    return SessionState(status: status ?? this.status, user: user ?? this.user);
  }
}
