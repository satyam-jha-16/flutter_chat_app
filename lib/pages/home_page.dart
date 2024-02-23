import "package:chat/components/my_drawer.dart";
import "package:chat/components/user_tile.dart";
import "package:chat/pages/chat_page.dart";
import "package:chat/services/auth/auth_service.dart";
import "package:chat/services/chat/chat_service.dart";
import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.transparent,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //widget userlist
  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: ((context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading...");
          }

          //listview
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildListItem(userData, context))
                .toList(),
          );
        }));
  }

  Widget _buildListItem(Map<String, dynamic> userData, BuildContext context) {
    //display all users except current user
    if(userData["email"] != _authService.getCurrentUser()!.email){
      return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
              ),
            ));
      },
    );
    }else{
      return Container();
    }
  }
}
