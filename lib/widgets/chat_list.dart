import 'package:flutter/cupertino.dart';
import 'package:whatsapp/widgets/info.dart';
import 'package:whatsapp/widgets/my_message_card.dart';
import 'package:whatsapp/widgets/sender_message_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          if (messages[index]['isMe'] == true) {
            //my card
            return MyMessageCard(
                date: messages[index]['time'].toString(),
                message: messages[index]['text'].toString());
          }
          //sender card
          return SenderMessageCard(
              date: messages[index]['time'].toString(),
              message: messages[index]['text'].toString());
        });
  }
}
