// SharedPreferences moved to data layer; LoginBloc only handles state.
import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_state.dart';
import 'package:bpp/features/authentication/data/models/user_model.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_block.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final SessionBloc? sessionBloc;

  LoginBloc(this.userRepository, {this.sessionBloc})
    : super(const LoginState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final res = await userRepository.loginUser(
        email: event.email,
        password: event.password,
      );

      // If the repository indicates success, move to success state.
      // We keep this minimal — UI can react to `status` and `user` if needed.
      if (res is Map && res['status'] == 'success') {
        // Extract user from response data and emit success. Persistence
        // is handled in the data layer (`AuthLocalDataSource`).
        final data = res['data'] != null && res['data'] is Map
            ? Map<String, dynamic>.from(res['data'])
            : <String, dynamic>{};

        final user = data.isNotEmpty ? UserModel.fromJson(data) : null;

        // Notify session bloc (if injected) to update in-memory session state
        sessionBloc?.add(FetchUserEvent(user: user));

        emit(state.copyWith(status: LoginStatus.success, user: user));
      } else {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: res is Map
                ? (res['message']?.toString() ?? 'Login failed')
                : 'Login failed',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
