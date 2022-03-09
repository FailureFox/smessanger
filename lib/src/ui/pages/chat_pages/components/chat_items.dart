import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      onLongPress: showMyDialog,
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
      trailing: Column(children: [
        Text(widget.chat.time),
      ]),
      subtitle: Text((widget.chat.lastMessage!)),
    );
  }

  showMyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                  Navigator.pop(context);
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
                onPressed: () {},
                child: const Text('Delete')),
          )
        ],
      ),
    );
  }
}
