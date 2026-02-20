import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bpp/core/constants/app_constant.dart';
import 'package:bpp/core/routes/app_routes.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_block.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_event.dart';
import 'package:bpp/features/authentication/presentation/bloc/session/session_state.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  //UserModel? _user;
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
    // final state = context.read<UserBloc>().state;
    // if (state is LoginSuccessState) {
    //   _user = state.user;
    //   print('user ====> $_user');
    // } // cast if needed
    // _loadUser();
  }

  /*
  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(AppConstants.USERDATAKEY);
    print('user from ===> $userString');
    setState(() {
      _user = UserModel.fromJson(jsonDecode(userString!));
      print('user from ===> $_user');
    });
  }
*/
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<SessionBloc>().add(LogoutUserEvent());
                // Perform logout logic here
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                // Add your logout navigation logic
                // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              child: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /*
  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('About'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'E-Commerce App',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Version: 1.0.0'),
              SizedBox(height: 8),
              Text('A modern e-commerce application built with Flutter.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    //final state = context.watch<UserBloc>().state;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings'),
      //   actions: [
      //     IconButton(
      //       onPressed: _showAboutDialog,
      //       icon: Icon(Icons.info_outline),
      //     ),
      //   ],
      // ),
      body: ListView(
        padding: EdgeInsets.only(bottom: 16, left: 10, right: 10, top: 0),
        children: [
          // Profile Section
          Card(
            child: BlocBuilder<SessionBloc, SessionState>(
              builder: (context, state) {
                //print('what si state ${state.status}');
                if (state.status == SessionStatus.authenticated &&
                    state.user != null) {
                  final user = state.user!;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Image.asset(
                        'assets/icons/man.png',
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      user.fullName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user.email),
                    onTap: () {
                      // Navigate to profile edit page
                    },
                  );
                }
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Image.asset(
                      'assets/icons/man.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "Guest User",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("guest@example.com"),
                );
              },
            ),
          ),

          SizedBox(height: 16),

          // Preferences Section
          Text(
            'PREFERENCES',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Notifications'),
                  subtitle: Text(
                    'Enable push notifications',
                    style: TextStyle(fontSize: 13),
                  ),
                  value: _notificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  secondary: Icon(Icons.notifications_active),
                ),
                Divider(height: 1),
                SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Enable dark theme'),
                  value: _darkModeEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                  secondary: Icon(Icons.dark_mode),
                ),
              ],
            ),
          ),

          SizedBox(height: 14),

          // Support Section
          Text(
            'SUPPORT',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.help_outline),
                  title: Text('Help & Support'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to help page
                    Navigator.pushNamed(context, AppRoutes.HELPPAGE);
                  },
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to privacy policy
                    Navigator.pushNamed(context, AppRoutes.PRIVACYPAGE);
                  },
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.description_outlined),
                  title: Text('Terms of Service'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    // Navigate to terms of service
                    Navigator.pushNamed(context, AppRoutes.TERMSPAGE);
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
          BlocBuilder<SessionBloc, SessionState>(
            builder: (context, state) {
              if (state.status == SessionStatus.authenticated) {
                return Column(
                  children: [
                    Text(
                      'ACCOUNT',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: _showLogoutDialog,
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),

          // Account Section
          SizedBox(height: 20),

          // App Info
          Center(
            child: Text(
              'Version ${AppConstants.VERSION}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
