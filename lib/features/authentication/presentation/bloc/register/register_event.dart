abstract class RegisterEvent {}

class UsernameChangedEvent extends RegisterEvent {
  final String username;
  UsernameChangedEvent(this.username);
}

/// Force an immediate check (skip debounce)
class CheckUsernameNowEvent extends RegisterEvent {
  final String username;
  CheckUsernameNowEvent(this.username);
}

class EmailChangedEvent extends RegisterEvent {
  final String email;
  EmailChangedEvent(this.email);
}

/// Force an immediate email check (skip debounce)
class CheckEmailNowEvent extends RegisterEvent {
  final String email;
  CheckEmailNowEvent(this.email);
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
