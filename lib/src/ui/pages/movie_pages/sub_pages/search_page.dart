import 'package:flutter/material.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';

class FilmsSearchPage extends StatefulWidget {
  const FilmsSearchPage({Key? key}) : super(key: key);

  @override
  State<FilmsSearchPage> createState() => _FilmsSearchPageState();
}

class _FilmsSearchPageState extends State<FilmsSearchPage> {
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
                      text: 'Films, serials and actors...',
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [],
            ),
          ),
        ],
      ),
    );
  }
}
