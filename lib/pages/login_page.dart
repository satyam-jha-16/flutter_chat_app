import 'package:chat/auth/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // email and pass controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();
    // try login 
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }catch(e){
      showDialog(context: context, builder: (context) =>AlertDialog(
        title: Text(e.toString()),
      ),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50),

            //welcome back message
            Text(
              "Welcome Back",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 20),
            ),

            //email text page
            const SizedBox(height: 25),

            //text field for email
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwController,
            ),

            //login button

            const SizedBox(height: 25),
            MyButton(
              BtnText: "Login",
              onTap: () => login(context),
            ),

            //register now
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                  "Register now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
