import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_state.dart';
import 'package:bpp/features/authentication/domain/usecases/get_saved_user_usecase.dart';
import 'package:bpp/features/authentication/data/models/user_model.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final GetSavedUserUseCase getSavedUserUseCase;

  /// SessionBloc manages authentication state (authenticated/unauthenticated)
  /// and the currently loaded `UserModel` in memory. It reads persisted
  /// session data via the provided `GetSavedUserUseCase` when constructed.
  SessionBloc(this.getSavedUserUseCase) : super(const SessionState()) {
    on<LoadUserFromPrefsEvent>(_onLoadUserFromPrefs);
    on<FetchUserEvent>(_onFetchUser);
    on<LogoutUserEvent>(_onLogoutUser);

    // Trigger a load of saved session data on creation so the app can
    // immediately reflect persisted authentication state.
    add(LoadUserFromPrefsEvent());
  }

  // We no longer persist or read SharedPreferences here by default.
  // `LoadUserFromPrefsEvent` will default to unauthenticated if no external
  // persistence is wired. Prefer calling `FetchUserEvent(user: ...)` after
  // a successful login to set session in-memory.
  FutureOr<void> _onLoadUserFromPrefs(
    LoadUserFromPrefsEvent event,
    Emitter<SessionState> emit,
  ) async {
    try {
      final saved = await getSavedUserUseCase.call();
      if (saved != null && saved.isNotEmpty) {
        final user = UserModel.fromJson(saved);
        emit(state.copyWith(status: SessionStatus.authenticated, user: user));
      } else {
        emit(state.copyWith(status: SessionStatus.unauthenticated, user: null));
      }
    } catch (_) {
      emit(state.copyWith(status: SessionStatus.unauthenticated, user: null));
    }
  }

  FutureOr<void> _onFetchUser(
    FetchUserEvent event,
    Emitter<SessionState> emit,
  ) {
    if (event.user != null) {
      emit(
        state.copyWith(status: SessionStatus.authenticated, user: event.user),
      );
    } else {
      emit(state.copyWith(status: SessionStatus.unauthenticated, user: null));
    }
  }

  FutureOr<void> _onLogoutUser(
    LogoutUserEvent event,
    Emitter<SessionState> emit,
  ) async {
    emit(state.copyWith(status: SessionStatus.unauthenticated, user: null));
  }
}
