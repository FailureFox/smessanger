import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_status.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_event.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/ui/pages/home_pages/chats_page.dart';
import 'package:smessanger/src/ui/pages/home_pages/sub_pages.dart/chat_room_page.dart';

class ChatItems extends StatefulWidget {
  const ChatItems({Key? key}) : super(key: key);

  @override
  State<ChatItems> createState() => _ChatItemsState();
}

class _ChatItemsState extends State<ChatItems> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(ChatLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
      final mystatus = state.status;
      if (mystatus == ChatStatus.loaded) {
        return ListTile(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => ChatInheritedWidget(
                    bloc: context.read<ChatBloc>(),
                    child: ChatRoomPage(homeBloc: context.read<HomeBloc>()),
                  ),
                ),
              );
            },
            leading: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                backgroundImage: NetworkImage(state.chatUser!.avatarUrl!),
                backgroundColor: Theme.of(context).backgroundColor,
                radius: MediaQuery.of(context).size.width / 14,
              ),
            ),
            title: Text(state.chatUser!.name),
            trailing: Column(children: [
              Text(state.lastMessageTime),
            ]),
            subtitle: Text((state.messages!.last as MessageTextModel).message));
      } else {
        return const ChatListLoadingItems();
      }
    });
  }
}
