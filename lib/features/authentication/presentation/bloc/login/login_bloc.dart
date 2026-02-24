// SharedPreferences moved to data layer; LoginBloc only handles state.
import 'package:bpp/features/authentication/domain/usecases/login_user_usecase.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_state.dart';
import 'package:bpp/features/authentication/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase loginUserUseCase;

  LoginBloc({required this.loginUserUseCase}) : super(const LoginState()) {
    on<LoginSubmittedEvent>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmittedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final res = await loginUserUseCase(
        email: event.email,
        password: event.password,
      );
      // Repository should return a `UserModel` on success, or an error Map on failure.
      if (res is UserModel) {
        //print('what is res $res');
        final user = res;
        emit(state.copyWith(status: LoginStatus.success, user: user));
      } else {
        //print('opps not a user model type $res');
        final message = res is Map
            ? (res['message']?.toString() ?? 'Login failed')
            : 'Login failed';
        emit(
          state.copyWith(status: LoginStatus.failure, errorMessage: message),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
