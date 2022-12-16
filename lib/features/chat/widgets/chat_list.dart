import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/models/message.dart';

import 'package:whatsapp/widgets/info.dart';
import 'package:whatsapp/widgets/my_message_card.dart';
import 'package:whatsapp/widgets/sender_message_card.dart';

class ChatList extends ConsumerWidget {
  final String recieverUserId;
  const ChatList({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).chatStream(recieverUserId),
        builder: (context, snapshot) {
          print(snapshot.hasData);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: messagesConst.length,
                  itemBuilder: (context, index) {
                    final messageData = snapshot.data![index];

                    if (messagesConst[index]['isMe'] == true) {
                      //my card
                      return MyMessageCard(
                        date: messagesConst[index]['time'].toString(),
                        message: messageData.text,
                      );
                    }
                    //sender card
                    return SenderMessageCard(
                      date: messagesConst[index]['time'].toString(),
                      message: messageData.text,
                    );
                  })
              : Container();
        });
  }
}
