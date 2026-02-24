import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_state.dart';
import 'package:bpp/features/authentication/presentation/pages/login_page.dart';
import 'package:bpp/core/presentation/widgets/snack_bar_helper.dart';
import 'package:bpp/features/authentication/presentation/widgets/app_text_form_field.dart';
import 'package:bpp/core/utils/validators/validator_builder.dart';
import 'package:bpp/core/theme/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormFieldState<String>> _usernameFieldKey =
      GlobalKey<FormFieldState<String>>();
  // Stable key for the username tooltip so it can be shown reliably on tap.
  final GlobalKey<TooltipState> _usernameTooltipKey = GlobalKey<TooltipState>();

  bool isLoading = false;
  bool _obsecurePassword = true;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileNoController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  // SnackBar helper moved to `lib/core/presentation/widgets/snack_bar_helper.dart`

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listenWhen: (previous, current) =>
            previous.usernameStatus != current.usernameStatus ||
            previous.status != current.status,
        listener: (context, state) {
          setState(() {
            isLoading = state.status == RegisterStatus.loading;
          });

          if (state.usernameStatus == UsernameStatus.taken) {
            context.showAppSnackBar(
              "Username '${userNameController.text.trim()}' already taken",
              success: false,
            );
            // Mark the username field as invalid so the user sees inline error immediately.
            _usernameFieldKey.currentState?.validate();
          } else if (state.usernameStatus == UsernameStatus.available) {
            context.showAppSnackBar(
              "Username '${userNameController.text.trim()}' is available",
              success: true,
            );
            _usernameFieldKey.currentState?.validate();
          } else if (state.usernameStatus == UsernameStatus.error) {
            context.showAppSnackBar(
              state.usernameErrorMessage ??
                  "Username '${userNameController.text.trim()}' check failed",
              success: false,
            );
            _usernameFieldKey.currentState?.validate();
          }

          if (state.status == RegisterStatus.failure) {
            context.showAppSnackBar(
              state.errorMessage ?? 'Register failed',
              success: false,
            );
          }

          if (state.status == RegisterStatus.success) {
            context.showAppSnackBar(
              "User '${userNameController.text.trim()}' registered successfully",
              success: true,
            );
            Navigator.pop(context);
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/signup.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Create\nAccount!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 55),

                    // Full name
                    AppTextFormField(
                      controller: fullNameController,
                      labelText: 'Full Name',
                      hintText: 'Enter Full Name',
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      validator: ValidatorBuilder.compose([
                        ValidatorBuilder.required(
                          message: 'Enter should not be empty',
                        ),
                        ValidatorBuilder.isString(
                          message: 'Only letters and spaces allowed',
                        ),
                      ]),
                    ),
                    SizedBox(height: 16),

                    // Username field with status suffix (loading / success / error)
                    BlocSelector<RegisterBloc, RegisterState, UsernameStatus>(
                      selector: (state) => state.usernameStatus,
                      builder: (context, usernameStatus) {
                        Widget? suffix;
                        if (usernameStatus == UsernameStatus.checking) {
                          suffix = Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: AppDimensions.iconSpinnerSize,
                              height: AppDimensions.iconSpinnerSize,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        } else if (usernameStatus == UsernameStatus.available) {
                          suffix = Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                          );
                        } else if (usernameStatus == UsernameStatus.taken) {
                          final msg =
                              context
                                  .read<RegisterBloc>()
                                  .state
                                  .usernameErrorMessage ??
                              '${userNameController.text.trim()} is already taken';
                          suffix = Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _usernameTooltipKey.currentState
                                  ?.ensureTooltipVisible(),
                              child: Tooltip(
                                key: _usernameTooltipKey,
                                message: msg,
                                waitDuration: Duration.zero,
                                showDuration: Duration(seconds: 4),
                                child: Icon(
                                  Icons.cancel,
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          );
                        } else if (usernameStatus == UsernameStatus.error) {
                          final msg =
                              context
                                  .read<RegisterBloc>()
                                  .state
                                  .usernameErrorMessage ??
                              'Username check failed';
                          suffix = Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _usernameTooltipKey.currentState
                                  ?.ensureTooltipVisible(),
                              child: Tooltip(
                                key: _usernameTooltipKey,
                                message: msg,
                                waitDuration: Duration.zero,
                                showDuration: Duration(seconds: 4),
                                child: Icon(
                                  Icons.error_outline,
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          );
                        }

                        return AppTextFormField(
                          fieldKey: _usernameFieldKey,
                          controller: userNameController,
                          labelText: 'User Name',
                          hintText: 'User Name',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                          suffixIcon: suffix,
                          onChanged: (val) {
                            context.read<RegisterBloc>().add(
                              UsernameChangedEvent(val),
                            );
                          },
                          validator: (value) {
                            final lenErr = ValidatorBuilder.minLength(6)(value);
                            if (lenErr != null) {
                              return lenErr;
                            }
                            final status = context
                                .read<RegisterBloc>()
                                .state
                                .usernameStatus;
                            if (status == UsernameStatus.taken) {
                              return '$value is already taken';
                            }
                            if (status == UsernameStatus.error) {
                              return context
                                      .read<RegisterBloc>()
                                      .state
                                      .usernameErrorMessage ??
                                  'Username check failed';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    SizedBox(height: 6),

                    // Email with existence check suffix
                    BlocSelector<RegisterBloc, RegisterState, EmailStatus>(
                      selector: (state) => state.emailStatus,
                      builder: (context, emailStatus) {
                        Widget? suffix;
                        if (emailStatus == EmailStatus.checking) {
                          suffix = Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: AppDimensions.iconSpinnerSize,
                              height: AppDimensions.iconSpinnerSize,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        } else if (emailStatus == EmailStatus.available) {
                          suffix = Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                          );
                        } else if (emailStatus == EmailStatus.taken) {
                          suffix = Icon(Icons.cancel, color: AppColors.error);
                        }

                        return AppTextFormField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter email',
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          keyboardType: TextInputType.emailAddress,
                          suffixIcon: suffix,
                          onChanged: (val) {
                            context.read<RegisterBloc>().add(
                              EmailChangedEvent(val),
                            );
                          },
                          validator: (value) {
                            final reqErr = ValidatorBuilder.required(
                              message: 'Enter valid email',
                            )(value);
                            if (reqErr != null) {
                              return reqErr;
                            }
                            final fmtErr = ValidatorBuilder.email()(value);
                            if (fmtErr != null) {
                              return fmtErr;
                            }
                            final status = context
                                .read<RegisterBloc>()
                                .state
                                .emailStatus;
                            if (status == EmailStatus.taken) {
                              return '$value is already registered';
                            }
                            if (status == EmailStatus.error) {
                              return context
                                      .read<RegisterBloc>()
                                      .state
                                      .emailErrorMessage ??
                                  'Email check failed';
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    SizedBox(height: 16),

                    // Mobile
                    AppTextFormField(
                      controller: mobileNoController,
                      keyboardType: TextInputType.number,
                      labelText: 'Mobile No',
                      hintText: 'Mobile No',
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      validator: ValidatorBuilder.compose([
                        ValidatorBuilder.required(
                          message: 'Enter your contact number...',
                        ),
                        // Accept only digits with exact length 10.
                        ValidatorBuilder.numericLength(
                          10,
                          message: 'Enter a valid 10-digit number',
                        ),
                      ]),
                    ),

                    SizedBox(height: 16),

                    // Password
                    AppTextFormField(
                      controller: passwordController,
                      obscureText: _obsecurePassword,
                      labelText: 'Password',
                      hintText: 'Password',
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
                      validator: ValidatorBuilder.minLength(
                        6,
                        message: 'Minimum 6 character',
                      ),
                    ),

                    SizedBox(height: 16),

                    // Next / Submit
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: const Color(0xFF262951),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<RegisterBloc, RegisterState>(
                          builder: (_, state) {
                            return InkWell(
                              onTap: () {
                                if (!_formkey.currentState!.validate()) return;

                                // Dispatch registration; final username check runs in bloc.
                                setState(() {
                                  isLoading = true;
                                });
                                context.read<RegisterBloc>().add(
                                  RegisterSubmittedEvent(
                                    fullName: fullNameController.text.trim(),
                                    userName: userNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    mobile: mobileNoController.text,
                                  ),
                                );
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

                    SizedBox(height: 30),

                    // Sign Up Redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already has account? ',
                          style: TextStyle(
                            color: Color(0xFF262951),
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xFF262951),
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
        ),
      ),
    );
  }
}
