import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:bpp/features/authentication/presentation/bloc/register/register_state.dart';
import 'package:bpp/features/authentication/presentation/pages/login_page.dart';

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

  bool isLoading = false;
  bool _obsecurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 55),

                  //Name
                  TextFormField(
                    controller: fullNameController,

                    ///style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter Full Name',
                      labelText: 'Full Name',
                      labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    validator: (value) =>
                        value == null ? 'Enter should not be empty' : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: userNameController,

                    decoration: InputDecoration(
                      hintText: 'User Name',
                      labelText: 'User Name',

                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
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
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    //style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      labelText: 'Email',
                      //labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    validator: (value) =>
                        value == null ||
                            !value.contains('@') ||
                            !value.contains('.')
                        ? 'Enter valid email'
                        : null,
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: mobileNoController,
                    keyboardType: TextInputType.number,
                    //style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Mobile No',
                      labelText: 'Mobile No',
                      //labelStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.phone, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    validator: (value) {
                      RegExp contactRegex = RegExp(r'^[6-9]\d{9}$');

                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your contact number...';
                      }
                      // Match: +91 followed by space and 10-digit Indian number
                      else if (!contactRegex.hasMatch(value.trim())) {
                        return 'Enter a valid 10-digit number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  //password
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obsecurePassword,
                    //style: TextStyle(color: Colors.white),
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
                        borderSide: BorderSide(color: Colors.white, width: 1.5),
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
                  SizedBox(height: 16),
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
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (_, state) {
                          if (state.status == RegisterStatus.loading) {
                            isLoading = true;
                          }

                          if (state.status == RegisterStatus.failure) {
                            isLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.errorMessage ?? 'Register failed',
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }

                          if (state.status == RegisterStatus.success) {
                            isLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('User Registered successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        builder: (_, state) {
                          return InkWell(
                            onTap: () {
                              if (_formkey.currentState!.validate()) {
                                isLoading = true;
                                context.read<RegisterBloc>().add(
                                  RegisterSubmittedEvent(
                                    fullName: fullNameController.text.trim(),
                                    userName: userNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    mobile: mobileNoController.text,
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
    );
  }
}
