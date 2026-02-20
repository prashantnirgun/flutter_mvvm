abstract class SignupState {}

class SignupInitial extends SignupState {}

/// Emitted while waiting for debounce or during network call.
class UsernameChecking extends SignupState {}

/// Username is available for registration.
class UsernameAvailable extends SignupState {}

/// Username already exists.
class UsernameTaken extends SignupState {}

class UsernameCheckError extends SignupState {
  final String message;
  UsernameCheckError(this.message);
}
