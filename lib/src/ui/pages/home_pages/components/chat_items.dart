import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_status.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_event.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/ui/pages/home_pages/chats_page.dart';

class ChatItems extends StatefulWidget {
  const ChatItems({Key? key}) : super(key: key);

  @override
  State<ChatItems> createState() => _ChatItemsState();
}

class _ChatItemsState extends State<ChatItems> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatBloc>().add(ChatLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      final mystatus = state.status;
      if (mystatus == ChatStatus.loaded) {
        return ListTile(
            leading: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                backgroundImage: NetworkImage(state.chatUser!.avatarUrl),
                backgroundColor: Theme.of(context).backgroundColor,
                radius: MediaQuery.of(context).size.width / 14,
              ),
            ),
            title: Text(state.chatUser!.name),
            trailing: Column(children: [
              SizedBox(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 10,
                  child:
                      Text(state.messages!.last.dateTime.toDate().toString())),
            ]),
            subtitle: Text(state.messages!.last.message));
      } else {
        return const ChatListLoadingItems();
      }
    });
  }
}
