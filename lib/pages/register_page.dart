import "package:chat/auth/auth_service.dart";
import "package:chat/components/my_button.dart";
import "package:chat/components/my_text_field.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cnfpwController = TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    // get auth service
    final _auth = AuthService();

    //passwords match --> sign up user
    if(_pwController.text == _cnfpwController.text){
      try{
        _auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      }catch(e){
        showDialog(context: context, builder: (context) =>AlertDialog(
          title: Text(e.toString()),
        ));
      }
    }

    //else -- tell user to fix the error
    else{
      showDialog(context: context, builder: (context) =>const AlertDialog(
          title: Text("passwords don't match"),
        ));   

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
              "Let's create an account for you",
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
            const SizedBox(height: 10),
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _cnfpwController,
            ),

            //login button

            const SizedBox(height: 25),
            MyButton(
              BtnText: "Register",
              onTap: () => register(context),
            ),

            //register now
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}