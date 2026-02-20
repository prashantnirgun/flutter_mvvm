import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/check_user_exists.dart';
import 'signup_event.dart';
import 'signup_state.dart';

/// Bloc responsible for username availability checking with debounce.
/// Implementation notes:
/// - Debounce belongs here (presentation layer).
/// - On `UsernameChanged` schedule a debounced call to the `CheckUserExists` usecase.
/// - Emit `UsernameChecking`, then `UsernameAvailable` / `UsernameTaken` / `UsernameCheckError`.
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final CheckUserExists checkUserExists;
  Timer? _debounceTimer;

  SignupBloc({required this.checkUserExists}) : super(SignupInitial()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<CheckUsernameNow>(_onCheckUsernameNow);
  }

  Future<void> _onUsernameChanged(
    UsernameChanged event,
    Emitter<SignupState> emit,
  ) async {
    // Cancel previous debounce timer and start a new one.
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      add(CheckUsernameNow(event.userName));
    });
    // Optionally emit an intermediate idle/checking state here.
  }

  Future<void> _onCheckUsernameNow(
    CheckUsernameNow event,
    Emitter<SignupState> emit,
  ) async {
    emit(UsernameChecking());
    try {
      final exists = await checkUserExists.call(event.userName);
      if (exists) {
        emit(UsernameTaken());
      } else {
        emit(UsernameAvailable());
      }
    } catch (e) {
      emit(UsernameCheckError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
