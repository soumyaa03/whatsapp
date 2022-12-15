import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/widgets/loader.dart';

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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final messageData = snapshot.data![index];
                if (messages[index]['isMe'] == true) {
                  //my card
                  return MyMessageCard(
                    date: messageData.text,
                    message: messages[index]['text'].toString(),
                  );
                }
                //sender card
                return SenderMessageCard(
                  date: messages[index]['time'].toString(),
                  message: messageData.text,
                );
              });
        });
  }
}
