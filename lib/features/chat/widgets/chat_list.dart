import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/widgets/my_message_card.dart';
import 'package:whatsapp/features/chat/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<ChatList> {
  final ScrollController messageScrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    messageScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //dont know why but I can use ref without getting it in the params Widget build
    return StreamBuilder<QuerySnapshot>(
        stream:
            ref.read(chatControllerProvider).chatStream(widget.recieverUserId),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageScrollController
                .jumpTo(messageScrollController.position.maxScrollExtent);
          });
          log(snapshot.hasData.toString());
          return snapshot.hasData
              ? ListView.builder(
                  controller: messageScrollController,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    final String messageData =
                        snapshot.data.docs[index]['text'];
                    final String senderid =
                        snapshot.data.docs[index]['senderId'];

                    var timeSent =
                        snapshot.data.docs[index]['timesent'].toString();
                    var messageType = snapshot.data.docs[index]['type'];
                    log(messageType);
                    if (senderid == FirebaseAuth.instance.currentUser!.uid) {
                      //my card

                      return MyMessageCard(
                        date: timeSent,
                        message: messageData,
                        type: messageType,
                      );
                    }
                    //sender card
                    return SenderMessageCard(
                      date: timeSent,
                      message: messageData,
                      type: messageType,
                    );
                  })
              : Container();
        });
  }
}
