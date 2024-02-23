import "package:chat/auth/auth_service.dart";
import "package:chat/components/my_drawer.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
