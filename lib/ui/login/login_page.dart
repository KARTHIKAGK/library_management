import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:library_management/logic/locator.dart';
import 'package:library_management/ui/components/main_text.dart';



class LoginPage extends StatelessWidget {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  const LoginPage({super.key});

  void _signIn() {
    final email = emailController.text;
    final password = passwordController.text;

    Locator.userManagementService.signInWithEmailAndPassword(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/books.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildForm(),
        ),
      ),
    ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300,
            height: 400,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromARGB(179, 255, 255, 255), // Background color of the rectangle
              borderRadius: BorderRadius.circular(12), // Rounded corners
              border: Border.all(
                  color: Colors.black, width: 2), // Border color and width
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(child:Image.asset("assets/books.jpg"),width:100,height:100),
            const Align(
              alignment: Alignment.center,
              child: MainText(
                text: "Welcome to Login",
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: emailController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              validator: (value) {
                final emailRegex =
                    RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                if (value!.isEmpty) {
                  return 'Please enter an email address';
                } else if (!emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              style: const TextStyle(color: Colors.black),
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  borderSide: BorderSide
                      .none, // No border outside the rounded rectangle
                ),
                filled: true, // Enable filling the TextFormField
                fillColor: Colors.white, // Default background color
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Rounded corners on focus
                  borderSide: const BorderSide(
                      color: Colors.black), // Border color on focus
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a password';
                } else if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('Login'), // This is the child widget
              onPressed: () {
                if (_formKey.currentState!.validate()) _signIn();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
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
