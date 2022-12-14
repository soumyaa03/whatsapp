import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/colors.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:whatsapp/features/chat/widgets/contact_list.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  static const String routeName = '/mobile-screen-layout';
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: appBarColor,
              elevation: 0,
              title: const Text(
                'WhatsApp',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  ),
                ),
              ],
              bottom: const TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 4,
                  labelColor: tabColor,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: 'Chat'),
                    Tab(text: 'Status'),
                    Tab(text: 'Calls')
                  ])),
          body: const ContactList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, SelectContactScreen.routeName);
            },
            backgroundColor: tabColor,
            child: const Icon(
              Icons.comment,
              color: Colors.white,
            ),
          ),
        ));
  }
}
