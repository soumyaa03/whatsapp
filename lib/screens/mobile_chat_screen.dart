import 'package:flutter/material.dart';

import 'package:whatsapp/colors.dart';
import 'package:whatsapp/widgets/chat_list.dart';
import 'package:whatsapp/widgets/info.dart';

class MobileChatScreen extends StatelessWidget {
  static const String routeName = '/mobile-chat-screen';
  const MobileChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(info[0]['name'].toString()),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.video_call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/wp2.jpg"), fit: BoxFit.cover)),
          ),
          Column(
            children: const [Expanded(child: ChatList())],
          ),
        ],
      ),
    );
  }
}
