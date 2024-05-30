import 'dart:io';
import 'package:cte_admin/pages/register_page.dart';
import 'package:cte_admin/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  // login function
  _login() async {
    await _auth.loginUserWithEmailAndPassword(
        _emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        } else {
          // print("show dialog");
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Cooth The Explorer"),
              content: const Text("Are you sure you want to exit?"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: const Text("No"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    exit(0);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: const Text("Yes"),
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        //  backgroundColor: Color(0xff06DD28),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 100,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                // logo
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "COORG",
                          style: TextStyle(
                            color: Color(0xff06DD28),
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "THE EXPLORER",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Welcome back,",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Login to manage your HomeStays and Taxi page",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                // form
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      // email
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // password
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          labelText: "Password",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // forgot password / remember  me

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // remember me
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                value: true,
                                onChanged: (value) {},
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              )
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                      // ----------------------------
                      const SizedBox(
                        height: 25,
                      ),
                      // sign in button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: _login,
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // create button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text("Create Account"),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                // or sign in with Google/Fb/
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      ),
                    ),
                    Text(
                      "Or Sign In With",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    Flexible(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // google and Facebook login button
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : IconButton(
                            onPressed: () async {
                              //
                              setState(() {
                                isLoading = true;
                              });
                              await _auth.loginWithGoogle();
                              setState(() {
                                isLoading = false;
                              });
                            },
                            icon: const Image(
                              width: 24,
                              height: 24,
                              image:
                                  AssetImage("assets/images/icons_google.png"),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
