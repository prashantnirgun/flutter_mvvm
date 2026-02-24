import 'package:bpp/core/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/core/network/api_helper.dart';

import 'package:bpp/features/data/repositories_impl/user_repository_impl.dart';
import 'package:bpp/features/authentication/data/datasources/user_remote_data_source_impl.dart';
import 'package:bpp/features/authentication/data/datasources/auth_local_data_source.dart';

import 'package:bpp/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_block.dart';

import 'package:bpp/features/authentication/domain/usecases/get_saved_user_usecase.dart';
import 'package:bpp/features/authentication/domain/usecases/check_user_exists_usecase.dart';
import 'package:bpp/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:bpp/features/authentication/domain/usecases/logout_user_usecase.dart';
import 'package:bpp/features/authentication/domain/usecases/login_user_usecase.dart';

void main() {
  // Create shared data-layer instances once and reuse them across blocs.
  final apiHelper = ApiHelper();
  final authLocal = AuthLocalDataSourceImpl();
  final userRemote = UserRemoteDataSourceImpl(apiHelper: apiHelper);
  final userRepository = UserRepositoryImpl(
    apiHelper: apiHelper,
    authLocalDataSource: authLocal,
    userRemoteDataSource: userRemote,
  );
  final getSavedUserUseCase = GetSavedUserUseCase(userRepository);
  final checkUserExistsUseCase = CheckUserExistsUseCase(userRepository);
  final registerUserUseCase = RegisterUserUseCase(userRepository);
  final logoutUserUseCase = LogoutUserUseCase(userRepository);
  final loginUserUseCase = LoginUserUseCase(userRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        // SessionBloc loads saved session using the domain usecase.
        BlocProvider<SessionBloc>(
          create: (context) =>
              SessionBloc(getSavedUserUseCase, logoutUserUseCase),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginUserUseCase: loginUserUseCase),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            checkUserExistsUseCase: checkUserExistsUseCase,
            registerUserUseCase: registerUserUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Smart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.SPLASHPAGE,
      routes: AppRoutes.pageRoutes(),
    );
  }
}
