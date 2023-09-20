import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Bubble(
      padding: BubbleEdges.all(10),
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: Text(message),
    );
  }
}



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = ["Hello", "Hi", "How are you?"];

  // Function to show the chat icon when a new message arrives
  void showChatIcon() {
    // Your logic to show the chat icon
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: messages[index],
                  isMe: index % 2 == 0,
                );
              },
            ),
          ),
          TextField(
            onSubmitted: (text) {
              setState(() {
                messages.add(text);
              });
              showChatIcon();  // Show chat icon when a new message arrives
            },
          ),
        ],
      ),
    );
  }
}


