import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';

class ChatSearchPage extends StatefulWidget {
  const ChatSearchPage({Key? key}) : super(key: key);

  @override
  State<ChatSearchPage> createState() => _ChatSearchPageBodyState();
}

class _ChatSearchPageBodyState extends State<ChatSearchPage> {
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

  String lastInputValue = '';
  Timer? _debounce;
  _onSearchChanged(VoidCallback function) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      function();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            title: AnimatedCrossFade(
                firstChild: Text(
                  'Search',
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
                    Text('Search',
                        style: Theme.of(context).textTheme.headline1),
                    SearchInput(
                      enabled: true,
                      onTap: () {},
                      onChanged: (text) {
                        if (text != lastInputValue) {
                          lastInputValue = text;
                          _onSearchChanged(
                            () {},
                          );
                        }
                      },
                      text: 'Chats, channels and peoples...',
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
