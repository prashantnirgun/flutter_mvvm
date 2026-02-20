abstract class SignupEvent {}

/// Dispatched when the username text field changes.
class UsernameChanged extends SignupEvent {
  final String userName;

  UsernameChanged(this.userName);
}

/// Optional: force an immediate check (skip debounce)
class CheckUsernameNow extends SignupEvent {
  final String userName;
  CheckUsernameNow(this.userName);
}
