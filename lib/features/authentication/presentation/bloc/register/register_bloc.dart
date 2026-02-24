import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_state.dart';
import 'package:bpp/features/authentication/domain/usecases/check_user_exists_usecase.dart';
import 'package:bpp/features/authentication/domain/usecases/register_user_usecase.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final CheckUserExistsUseCase checkUserExistsUseCase;
  final RegisterUserUseCase registerUserUseCase;
  Timer? _debounceTimer;
  Timer? _emailDebounceTimer;
  String? _lastCheckedUsername;
  String? _lastCheckedEmail;

  RegisterBloc({
    required this.checkUserExistsUseCase,
    required this.registerUserUseCase,
  }) : super(const RegisterState()) {
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
    on<UsernameChangedEvent>(_onUsernameChanged);
    on<EmailChangedEvent>(_onEmailChanged);
    on<CheckUsernameNowEvent>(_onCheckUsernameNow);
    on<CheckEmailNowEvent>(_onCheckEmailNow);
  }

  FutureOr<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    // Final server-side username existence check to avoid race conditions.
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      final res = await registerUserUseCase(
        fullName: event.fullName,
        userName: event.userName,
        email: event.email,
        password: event.password,
        mobile: event.mobile,
      );

      if (res is Map && res['status'] == 'success') {
        emit(state.copyWith(status: RegisterStatus.success));
      } else {
        emit(
          state.copyWith(
            status: RegisterStatus.failure,
            errorMessage: res is Map
                ? (res['message']?.toString() ?? 'Register failed')
                : 'Register failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUsernameChanged(
    UsernameChangedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    // debounce
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      add(CheckUsernameNowEvent(event.username));
    });
  }

  Future<void> _onEmailChanged(
    EmailChangedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    _emailDebounceTimer?.cancel();
    _emailDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      add(CheckEmailNowEvent(event.email));
    });
  }

  Future<void> _onCheckUsernameNow(
    CheckUsernameNowEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final username = event.username.trim();
    if (username.isEmpty) return;
    // If we've already checked this exact username, skip re-checking.
    if (_lastCheckedUsername != null && _lastCheckedUsername == username) {
      return;
    }
    _lastCheckedUsername = username;
    emit(
      state.copyWith(
        usernameStatus: UsernameStatus.checking,
        usernameErrorMessage: null,
      ),
    );
    try {
      final exists = await checkUserExistsUseCase('user_name', username);
      if (exists) {
        emit(state.copyWith(usernameStatus: UsernameStatus.taken));
      } else {
        emit(state.copyWith(usernameStatus: UsernameStatus.available));
      }
    } catch (e) {
      emit(
        state.copyWith(
          usernameStatus: UsernameStatus.error,
          usernameErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCheckEmailNow(
    CheckEmailNowEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final email = event.email.trim();
    if (email.isEmpty) return;
    if (_lastCheckedEmail != null && _lastCheckedEmail == email) return;
    _lastCheckedEmail = email;
    emit(
      state.copyWith(
        emailStatus: EmailStatus.checking,
        emailErrorMessage: null,
      ),
    );
    try {
      final exists = await checkUserExistsUseCase('email', email);
      if (exists) {
        emit(state.copyWith(emailStatus: EmailStatus.taken));
      } else {
        emit(state.copyWith(emailStatus: EmailStatus.available));
      }
    } catch (e) {
      emit(
        state.copyWith(
          emailStatus: EmailStatus.error,
          emailErrorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    _emailDebounceTimer?.cancel();
    return super.close();
  }
}
