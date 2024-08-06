import 'package:flutter/material.dart';
import 'package:medisnap/constants/colors.dart';
import 'package:medisnap/provider/auth_provider.dart';
import 'package:medisnap/provider/user_provider.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Regsiter to use the App",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: primaryColor,
        foregroundColor: textColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 180,
                color: secondaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: TextField(
                  controller: _email,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text(
                      "Enter email address",
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: secondaryColor,
                    ),
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: textColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: secondaryColor,
                        width: 1,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: textColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 30,
                ),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    label: Text(
                      "Enter a password",
                      style: TextStyle(
                        color: secondaryColor,
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: secondaryColor,
                    ),
                    prefixIcon: Icon(Icons.password),
                    prefixIconColor: textColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textColor,
                        width: 1,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;

                  try {
                    await Provider.of<FirebaseAuthProvider>(context,
                            listen: false)
                        .signUp(email, password);
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    await userProvider.initializeUserDocument();

                    Navigator.pushReplacementNamed(context, '/intro');
                  } catch (e) {
                    print("Sign-up failed: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text(
                  "Already a user? Login",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
