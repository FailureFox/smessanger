import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/ui/pages/chat_pages/sub_pages/chat_room_page.dart';
import 'package:smessanger/src/ui/styles/colors.dart';

class ChatItems extends StatefulWidget {
  final ChatModel chat;
  const ChatItems({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatItems> createState() => _ChatItemsState();
}

class _ChatItemsState extends State<ChatItems> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => showDeleteChatDialog(widget.chat, context),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => ChatRoomPage(
              chatId: widget.chat.chatId,
              user: widget.chat.chatUser,
            ),
          ),
        );
      },
      leading: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(100),
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.chat.chatUser.avatarUrl!),
          backgroundColor: Theme.of(context).backgroundColor,
          radius: MediaQuery.of(context).size.width / 14,
        ),
      ),
      title: Text(widget.chat.chatUser.name),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(widget.chat.time),
        const SizedBox(width: 5),
        CircleAvatar(
          radius: 15,
          child: Text(widget.chat.notReadedCount.toString(),
              style: Theme.of(context).textTheme.caption),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ]),
      subtitle: Text((widget.chat.lastMessage!)),
    );
  }

  showDeleteChatDialog(ChatModel chat, context) {
    showDialog(
      context: context,
      builder: (secondContext) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceAround,
        title: const Center(child: Text('Delete сhat?')),
        content: Text(
          'The chat will be deleted for\neveryone. This cannot be undone',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .color!
                  .withOpacity(0.5),
              fontWeight: FontWeight.bold),
        ),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.width / 8.5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).bottomSheetTheme.backgroundColor,
                ),
                onPressed: () {
                  Navigator.pop(secondContext);
                },
                child: Text('Cancel',
                    style: TextStyle(color: Theme.of(context).hintColor))),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.width / 8.5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.redTint,
                ),
                onPressed: () {
                  BlocProvider.of<ChatBloc>(context).deleteChat(
                      chatId: chat.chatId,
                      companionId: chat.chatUser.uid,
                      myID: BlocProvider.of<AppBloc>(context).state.uid);
                  Navigator.pop(secondContext);
                },
                child: const Text('Delete')),
          )
        ],
      ),
    );
  }
}
