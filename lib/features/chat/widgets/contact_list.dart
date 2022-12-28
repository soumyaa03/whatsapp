import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/screens/mobile_chat_screen.dart';
import 'package:whatsapp/models/chat_contact.dart';

class ContactList extends ConsumerWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        //doubt : -how listview builder and divider works as children in  a coloumn instead of putting list tile and divider as children of list view builder
        children: [
          Expanded(
            child: StreamBuilder<List<ChatContact>>(
                stream: ref.watch(chatControllerProvider).chatContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var chatContactData = snapshot.data![index];
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, MobileChatScreen.routeName,
                                        arguments: {
                                          'name': chatContactData.name,
                                          'uid': chatContactData.contactId,
                                        });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ListTile(
                                      title: Text(chatContactData.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          )),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          chatContactData.lastMessage,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            chatContactData.profilePic),
                                        radius: 25,
                                      ),
                                      trailing: Text(
                                        chatContactData.timeSent,
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          })
                      : Container();
                }),
          ),
          const Divider(
            color: dividerColor,
            indent: 85,
          )
        ],
      ),
    );
  }
}
