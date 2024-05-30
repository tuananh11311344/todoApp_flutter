import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/src/components/pages/Login/Signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _passWord = '';
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_email == 'anh.nguyentuan3@ncc.asia' && _passWord == '123456') {
        context.go("/");
      }
    }
  }

  _signup() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => const Signup()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("assets/images/ncclogo2.png"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome NCC",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 40),
                ),
                const Text(
                  "We do it with passion",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 15),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "E-Mail",
                            border: OutlineInputBorder(),
                          ),
                          validator: (input) {
                            return input!.trim().isEmpty
                                ? "Please enter a email"
                                : null;
                          },
                          onChanged: (input) {
                            _email = input;
                          },
                          initialValue: _email,
                          onSaved: (input) {
                            _email = input!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.fingerprint),
                            labelText: "PassWord",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          validator: (input) {
                            return input!.trim().isEmpty
                                ? "Please enter a password"
                                : null;
                          },
                          onSaved: (input) {
                            _passWord = input!;
                          },
                          onChanged: (input) {
                            _passWord = input;
                          },
                          initialValue: _passWord,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: const TextButton(
                            onPressed: null,
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.withOpacity(0.8),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _login,
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("OR"),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton.icon(
                                icon: const Image(
                                  image: AssetImage(
                                      "assets/images/google-logo.png"),
                                  width: 20,
                                ),
                                onPressed: () {},
                                label: const Text(
                                  "Sign-IN with Google",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: _signup,
                              child: const Text.rich(
                                TextSpan(
                                  text: "Don't have an Account?",
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Signup",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
