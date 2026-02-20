abstract class RegisterEvent {}

class UsernameChangedEvent extends RegisterEvent {
  final String username;
  UsernameChangedEvent(this.username);
}

class RegisterSubmittedEvent extends RegisterEvent {
  final String fullName;
  final String userName;
  final String email;
  final String password;
  final String mobile;

  RegisterSubmittedEvent({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.password,
    required this.mobile,
  });
}
