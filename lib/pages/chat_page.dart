import "package:chat/components/chat_bubble.dart";
import "package:chat/components/my_text_field.dart";
import "package:chat/services/auth/auth_service.dart";
import "package:chat/services/chat/chat_service.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text controller
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for textfield focus

  FocusNode myFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        //cause a delay to show keyboard
        // then amount of remaining space will be calc
        // then scroll down 

        Future.delayed(const Duration(milliseconds: 500),() =>scrollDown());

      }
    });
    Future.delayed(const Duration(milliseconds: 500),
    () =>scrollDown());
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller 
  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  //send message
  void sendMessage() async {
    //if there is something inside the text field
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(widget.receiverID, _messageController.text);
      //clear the text field
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          //display all the messages
          Expanded(child: _buildMessageList()),

          //users input
          _buildUserInput(),
        ],
      ),
    );
  }

  // widget message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading...");
          }

          //return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //UI Changes 
    //is current user 
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align to right if sender -- align to left if reciever
    var align = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;


    return Container(
      alignment: align,
      child: Column(
        crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          ChatBubble(message: (data["message"]), isCurrentUser: isCurrentUser)
        ],
      )
      );
  }

  //build message input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          //textfield should take most of the space
          Expanded(
              child: MyTextField(
                focusNode: myFocusNode,
            controller: _messageController,
            hintText: "send something",
            obscureText: false,

          )),
       
          //send button
          Container(
            decoration: const BoxDecoration(color: Colors.green,
            shape: BoxShape.circle),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage, icon: const Icon(Icons.arrow_upward, color: Colors.white,)),
          ),
        ],
      ),
    );
  }
}
