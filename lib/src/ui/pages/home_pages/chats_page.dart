import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';

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
                  const SearchInput()
                ],
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
            children: [
              ...List.generate(15, (index) => const ChatListLoadingItems())
            ],
          ),
        ]))
      ],
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
