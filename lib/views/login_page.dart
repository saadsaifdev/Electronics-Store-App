import 'package:electrical_store_app/constants.dart';
import 'package:electrical_store_app/helper/show_snack_bar.dart';
import 'package:electrical_store_app/views/home_view.dart';
import 'package:electrical_store_app/views/register_view.dart';
import 'package:electrical_store_app/widgets/custom_button.dart';
import 'package:electrical_store_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading = false;
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Image.network(
                      kLogo,
                      height: 100,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.electrical_services,
                          size: 80,
                          color: Colors.white,
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(kAppTitle, style: kPacificoAuthTitleStyle),
                      ],
                    ),
                    const SizedBox(height: 80),
                    const Row(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      hintText: 'Email',
                      onChanged: (data) {
                        email = data;
                      },
                      validator: (data) {
                        if (data == null || data.isEmpty) {
                          return "Email is required";
                        }
                        bool isEmailValid = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(data);
                        if (!isEmailValid) {
                          return "Please enter a valid email format";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    CustomTextFormField(
                      obscureText: isPasswordHidden,
                      hintText: 'Password',
                      onChanged: (data) {
                        password = data;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    CustomButton(
                      onTap: () async {
                        await handleLogin();
                      },
                      text: 'Login',
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "don't have an account?",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterView.id);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> handleLogin() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        await loginUser();

        if (mounted) {
          showSnackBar(context, 'Login Successful!');
          Navigator.pushReplacementNamed(context, HomeView.id);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          if (e.code == 'user-not-found') {
            showSnackBar(context, 'No user found for that email.');
          } else if (e.code == 'wrong-password') {
            showSnackBar(context, 'Wrong password provided.');
          } else {
            showSnackBar(context, e.message ?? 'Authentication error');
          }
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(context, e.toString());
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
