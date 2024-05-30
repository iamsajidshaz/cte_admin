import 'package:cte_admin/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final _auth = AuthService();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  _signup() async {
    await _auth.createUserWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 25,
                  ),
                  Text(
                    "Lets create your Account",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // form
              Form(
                child: Column(
                  children: [
                    // first n last name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: "First Name",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Last Name",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
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
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Phone Number",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        labelText: "Password",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // remember me
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.blue,
                          value: true,
                          onChanged: (value) {},
                        ),
                        const Text(
                          "I agree to the Privacy Policy and Terms and Conditions",
                          style: TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    // ----------------------------
                    const SizedBox(
                      height: 10,
                    ),
                    // sign in button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: _signup,
                        child: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // create button
                    // create button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child:
                            const Text("Already have an account? Login Here"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                    "Or Sign Up With",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google
                  Container(
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
                              Navigator.pop(context);
                            },
                            icon: const Image(
                              width: 24,
                              height: 24,
                              image:
                                  AssetImage("assets/images/icons_google.png"),
                            ),
                          ),
                  ),
                  // const SizedBox(
                  //   width: 20,
                  // ),
                  // // facebook
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: Colors.grey,
                  //     ),
                  //     borderRadius: BorderRadius.circular(100),
                  //   ),
                  //   child: IconButton(
                  //     onPressed: () {},
                  //     icon: const Image(
                  //       width: 24,
                  //       height: 24,
                  //       image: AssetImage("assets/images/icons_facebook.png"),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
