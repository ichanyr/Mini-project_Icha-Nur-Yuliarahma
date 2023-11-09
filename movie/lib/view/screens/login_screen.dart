import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:movie/navigation_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // variabel untuk menyimpan SharedPreference dan nilai bool newUser
  late SharedPreferences loginData;
  late bool newUser;
  // method checkLogin()

  String nama() {
    String nama = 'test';
    return nama;
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = loginData.getBool('login') ?? true;

    if (newUser == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => NavigationScreen()),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Image.asset(
                      'assets/images/login.jpg',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your name';
                                }
                                if (value.trim().split(' ').length < 2) {
                                  return 'Name must contain at least two words';
                                }
                                if (!RegExp(
                                        r'^[A-Z][a-z]* [A-Z][a-z]* [A-Z][a-z]*$')
                                    .hasMatch(value.trim())) {
                                  return 'Name must start with a capital letter and contain at least three words';
                                }
                                return null;
                              },
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                icon: Icon(Icons.person),
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                final isEmailValidation =
                                    EmailValidator.validate(value);
                                if (!isEmailValidation) {
                                  return 'Please enter a valid email';
                                }

                                return null;
                              },
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                if (!RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least one number and one special character';
                                }
                                return null;
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                icon: Icon(Icons.key),
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final isValidation =
                                    formKey.currentState!.validate();
                                String username =
                                    _nameController.text; // inputan dari users
                                if (isValidation) {
                                  loginData.setBool('login', false);
                                  loginData.setString('username', username);
                                  // loginData.remove('username'); // menghapus local storage
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigationScreen()),
                                      (route) => false);
                                }
                                formKey.currentState!.validate();
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.black,
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  )),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
