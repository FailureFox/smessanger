import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_bloc.dart';
import 'package:smessanger/src/bloc/chats_bloc/chats_state.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';
import 'package:smessanger/src/ui/pages/chat_pages/components/chat_items.dart';
import 'package:smessanger/src/ui/pages/chat_pages/sub_pages/search_page.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();
  bool _isClosed = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isClosed = isClosed;
      setState(() {});
    });
  }

  bool get isClosed {
    return _controller.hasClients &&
        _controller.offset > (150 - kToolbarHeight);
  }

  static const String chatsText = 'Chats, channels and peoples...';
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      slivers: [
        SliverAppBar(
          centerTitle: true,
          pinned: true,
          title: AnimatedCrossFade(
              firstChild: Text(
                'Chats',
                style: Theme.of(context).textTheme.headline2,
              ),
              secondChild: const SizedBox(),
              crossFadeState: _isClosed
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300)),
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text('Chats', style: Theme.of(context).textTheme.headline1),
                  SearchInput(
                    enabled: false,
                    text: chatsText,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (mycontext, animation, animation2) =>
                              ChatSearchPage(
                                  chats: (BlocProvider.of<ChatBloc>(context)
                                          .state as ChatStateLoaded)
                                      .chats),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return BlocBuilder<ChatBloc, ChatState>(
              builder: (context, chatState) {
            if (state.status == HomeStatus.loaded &&
                chatState is ChatStateLoaded) {
              return const ChatsBody();
            } else {
              return const ChatLoadingBody();
            }
          });
        })
      ],
    );
  }
}

class ChatsBody extends StatelessWidget {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
            if (state is ChatStateLoaded) {
              return Column(
                children: [
                  ...state.chats.map((e) => ChatItems(chat: e)).toList()
                ],
              );
            } else {
              return Container();
            }
          })
        ],
      ),
    );
  }
}

class ChatLoadingBody extends StatelessWidget {
  const ChatLoadingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [
              ...List.generate(15, (index) => const ChatListLoadingItems())
            ],
          ),
        ],
      ),
    );
  }
}

class ChatListLoadingItems extends StatelessWidget {
  const ChatListLoadingItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(100),
        child: Shimmer(
            child: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          radius: MediaQuery.of(context).size.width / 14,
        )),
      ),
      title: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3),
        child: Shimmer(
            child: Container(
          color: Theme.of(context).backgroundColor,
          height: 10,
        )),
      ),
      trailing: Column(children: [
        SizedBox(
          height: 10,
          width: MediaQuery.of(context).size.width / 10,
          child: Shimmer(
            child: Container(
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ]),
      subtitle: Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 7),
        child: Shimmer(
          child: Container(
            color: Theme.of(context).backgroundColor,
            height: 10,
          ),
        ),
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
    required this.onTap,
    required this.text,
    required this.enabled,
    this.suffix,
    this.onChanged,
  }) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final bool enabled;
  final Widget? suffix;

  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: TextField(
          autofocus: enabled,
          enabled: enabled,
          maxLines: null,
          onChanged: onChanged ?? (String value) {},
          minLines: null,
          expands: true,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            suffix: suffix,
            prefixIcon: const Icon(Icons.search),
            hintText: text,
          ),
        ),
      ),
    );
  }
}
