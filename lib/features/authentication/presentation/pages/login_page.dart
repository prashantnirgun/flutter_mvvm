import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/core/routes/app_routes.dart';
import 'package:bpp/core/utils/dialogs.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/login/login_state.dart';
import 'package:bpp/features/authentication/presentation/pages/signup_page.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_block.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_event.dart';
//import 'package:quickalert/models/quickalert_type.dart';
//import 'package:quickalert/widgets/quickalert_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool _obsecurePassword = true;
  bool isLogin = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/login.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30, top: 90),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Welcome\nBack!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 150),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 87, 84, 84),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    //Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Email",
                        //labelText: 'Enter Email',
                        //labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.email, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      // validator: (value) =>
                      //     value == null ||
                      //         !value.contains('@') ||
                      //         !value.contains('.')
                      //     ? 'Enter valid email'
                      //     : null,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 87, 84, 84),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    //password
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obsecurePassword,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        //labelText: 'Password',
                        //labelStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obsecurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _obsecurePassword = !_obsecurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      validator: (value) => value == null || value.length < 6
                          ? 'Minimum 6 character'
                          : null,
                    ),
                    SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 87, 84, 84),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocConsumer<LoginBloc, LoginState>(
                          listenWhen: (current, previous) {
                            return isLogin;
                          },
                          buildWhen: (current, previous) {
                            return isLogin;
                          },
                          listener: (_, state) {
                            if (state.status == LoginStatus.loading) {
                              isLoading = true;
                            }

                            if (state.status == LoginStatus.failure) {
                              isLoading = false;
                              AppDialogs.showError(
                                context,
                                title: 'Login Failed',
                                desc:
                                    state.errorMessage ??
                                    'Wrong email or password. Please try again.',
                              );
                            }

                            if (state.status == LoginStatus.success) {
                              isLoading = false;
                              AppDialogs.showSuccess(
                                context,
                                title: 'Login Success',
                                desc: 'Redirecting to Dashboard...',
                                onOk: () {
                                  // Propagate logged-in user to SessionBloc (in-memory)
                                  context.read<SessionBloc>().add(
                                    FetchUserEvent(user: state.user),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.DASHBOARDPAGE,
                                  );
                                },
                                onDismiss: (type) {
                                  context.read<SessionBloc>().add(
                                    FetchUserEvent(user: state.user),
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.DASHBOARDPAGE,
                                  );
                                },
                              );
                            }
                          },
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                if (_formkey.currentState!.validate()) {
                                  isLoading = true;
                                  context.read<LoginBloc>().add(
                                    LoginSubmittedEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Color(0xff904c6e),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isLoading
                                      ? Icons.hourglass_full_outlined
                                      : Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Sign Up Redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have account? ',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
