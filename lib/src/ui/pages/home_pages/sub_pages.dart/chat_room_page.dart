import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_event.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/models/message_model.dart';
import 'package:smessanger/src/ui/pages/home_pages/components/messages_widget.dart';

class ChatRoomPage extends StatelessWidget {
  const ChatRoomPage({Key? key, required this.homeBloc}) : super(key: key);
  final HomeBloc homeBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
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
        title: BlocBuilder<ChatBloc, ChatState>(
          bloc: ChatInheritedWidget.of(context)!.bloc,
          builder: (context, state) {
            return ListTile(
              onTap: () {},
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(state.chatUser!.avatarUrl!),
              ),
              title: Text(state.chatUser!.name,
                  style: Theme.of(context).textTheme.headline2),
            );
          },
        ),
      ),
      body: Column(
        children: [
          const Expanded(child: ChatMessagesList()),
          MessageInputBar(uid: homeBloc.state.myProfile!.uid)
        ],
      ),
    );
  }
}

class MessageInputBar extends StatefulWidget {
  final String uid;

  const MessageInputBar({Key? key, required this.uid}) : super(key: key);

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
              height: MediaQuery.of(context).size.width / 10,
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
                maxLines: null,
                minLines: null,
                expands: true,
              ),
            ),
          ),
          controller.text == ''
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
              : IconButton(
                  onPressed: () {
                    final String text = controller.text;
                    ChatInheritedWidget.of(context)!.bloc.add(
                        ChatSendMessageEvent(message: text, uid: widget.uid));
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
  const ChatMessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      bloc: ChatInheritedWidget.of(context)!.bloc,
      builder: (context, state) {
        return AnimatedList(
          reverse: true,
          key: ChatInheritedWidget.of(context)!.bloc.listKey,
          initialItemCount: state.messages!.length,
          itemBuilder: (context, index, animation) {
            return MessagesWidget(
              animation: animation,
              message: state.messages![index] as MessageTextModel,
              userModel: state.chatUser!,
            );
          },
        );
      },
    );
  }
}

class ChatInheritedWidget extends InheritedWidget {
  final ChatBloc bloc;
  const ChatInheritedWidget(
      {Key? key, required Widget child, required this.bloc})
      : super(key: key, child: child);

  static ChatInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ChatInheritedWidget>();
  }

  @override
  bool updateShouldNotify(ChatInheritedWidget oldWidget) {
    return false;
  }
}
