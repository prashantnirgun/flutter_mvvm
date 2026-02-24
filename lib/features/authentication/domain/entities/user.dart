import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String fullName;
  final String userName;
  final String email;
  final String mobile;
  final String userStatus;
  final String uuid;
  final String session;
  final String userGroupName;
  final String emailVerified;

  const User({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.mobile,
    required this.userStatus,
    required this.uuid,
    required this.session,
    required this.userGroupName,
    required this.emailVerified,
  });

  @override
  List<Object?> get props => [
    id,
    uuid,
    fullName,
    email,
    mobile,
    userStatus,
    session,
    userGroupName,
    emailVerified,
  ];
}
