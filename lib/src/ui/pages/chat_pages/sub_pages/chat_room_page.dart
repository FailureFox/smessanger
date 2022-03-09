import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/app_bloc/app_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_room_bloc/chat_room_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chat_room_bloc/chat_room_state.dart';
import 'package:smessanger/src/models/chat_model.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/models/my_profile_model.dart';
import 'package:smessanger/src/resources/domain/repositories/chats_repository.dart';
import 'package:smessanger/src/ui/pages/chat_pages/components/messages_widget.dart';
import 'package:smessanger/src/ui/pages/home_pages/sub_pages.dart/profile_page.dart';
import 'package:smessanger/injections.dart' as rep;

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key, required this.chatId, required this.user})
      : super(key: key);
  final String? chatId;
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatRoomBloc>(
      create: (_) => ChatRoomBloc(
        uid: BlocProvider.of<AppBloc>(context).state.uid,
        chatId: chatId,
        chatRep: rep.sl.call<ChatsRepository>(),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .scaffoldBackgroundColor
                      .withOpacity(0.9),
                ),
              ),
            ),
          ),
          backgroundColor:
              Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.5),
          bottom: const PreferredSize(
            child: Divider(height: 1),
            preferredSize: Size.fromHeight(5),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios,
                color: Theme.of(context).iconTheme.color),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ProfilePage(profile: user),
                ),
              );
            },
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(user.avatarUrl!),
              ),
              title:
                  Text(user.name, style: Theme.of(context).textTheme.headline2),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: ChatMessagesList(user: user)),
            MessageInputBar(
              chatId: chatId,
              userId: user.uid,
            )
          ],
        ),
      ),
    );
  }
}

class MessageInputBar extends StatefulWidget {
  final String? chatId;
  final String userId;
  const MessageInputBar({Key? key, required this.chatId, required this.userId})
      : super(key: key);

  @override
  State<MessageInputBar> createState() => _MessageInputBarState();
}

class _MessageInputBarState extends State<MessageInputBar> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.file_present)),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions_outlined)),
                    fillColor: Theme.of(context).hoverColor,
                    hintText: 'Write your message here',
                    hintStyle: Theme.of(context).textTheme.bodyText2),
              ),
            ),
          ),
          controller.text == ''
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
              : IconButton(
                  onPressed: () {
                    final String text = controller.text;
                    BlocProvider.of<ChatRoomBloc>(context)
                        .sendMessage(companionId: widget.userId, message: text);
                    controller.clear();
                    setState(() {});
                  },
                  icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}

class ChatMessagesList extends StatelessWidget {
  final UserModel user;
  const ChatMessagesList({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatRoomBloc, ChatRoomState>(
      builder: (context, state) {
        final myState = state;
        if (myState is ChatRoomStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (myState is ChatRoomStateLoaded) {
          if (myState.messages.isNotEmpty) {
            return AnimatedList(
              reverse: true,
              key: BlocProvider.of<ChatRoomBloc>(context).listKey,
              initialItemCount: myState.messages.length,
              itemBuilder: (context, index, animation) {
                return MessagesWidget(
                  animation: animation,
                  message: myState.messages[index] as MessageTextModel,
                  userModel: user,
                  nextId: index > 0 ? myState.messages[index - 1].from : '',
                );
              },
            );
          } else {
            return const Center(
              child: Text('Пусто епт'),
            );
          }
        } else {
          return Container(
            color: Colors.cyan,
          );
        }
      },
    );
  }
}
