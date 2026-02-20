import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_state.dart';
import 'package:bpp/features/authentication/domain/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository userRepository;

  RegisterBloc({required this.userRepository}) : super(const RegisterState()) {
    on<RegisterSubmittedEvent>(_onRegisterSubmitted);
  }

  FutureOr<void> _onRegisterSubmitted(
    RegisterSubmittedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      final res = await userRepository.registerUser(
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
}
