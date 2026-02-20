enum RegisterStatus { initial, loading, success, failure }

enum UsernameStatus { initial, checking, available, taken, error }

class RegisterState {
  final RegisterStatus status;
  final UsernameStatus usernameStatus;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.usernameStatus = UsernameStatus.initial,
    this.errorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    UsernameStatus? usernameStatus,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
