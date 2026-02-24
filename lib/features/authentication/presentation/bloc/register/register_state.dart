import 'package:equatable/equatable.dart';

enum RegisterStatus { initial, loading, success, failure }

enum UsernameStatus { initial, checking, available, taken, error }

enum EmailStatus { initial, checking, available, taken, error }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final UsernameStatus usernameStatus;
  final EmailStatus emailStatus;
  final String? errorMessage;
  final String? usernameErrorMessage;
  final String? emailErrorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.usernameStatus = UsernameStatus.initial,
    this.emailStatus = EmailStatus.initial,
    this.errorMessage,
    this.usernameErrorMessage,
    this.emailErrorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    UsernameStatus? usernameStatus,
    EmailStatus? emailStatus,
    String? errorMessage,
    String? usernameErrorMessage,
    String? emailErrorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      usernameStatus: usernameStatus ?? this.usernameStatus,
      emailStatus: emailStatus ?? this.emailStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      usernameErrorMessage: usernameErrorMessage ?? this.usernameErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    usernameStatus,
    emailStatus,
    errorMessage,
    usernameErrorMessage,
    emailErrorMessage,
  ];
}
