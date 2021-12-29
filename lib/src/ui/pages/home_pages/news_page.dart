import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/resources/data/news_data.dart';
import 'package:smessanger/src/resources/data/news_data_use.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final ScrollController _controller = ScrollController();
  bool isClosed = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      isClosed = _isSliverAppBarExpanded;
      setState(() {});
    });
  }

  bool get _isSliverAppBarExpanded {
    return _controller.hasClients &&
        _controller.offset > (150 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverAppBar(
          elevation: 0,
          centerTitle: true,
          title: AnimatedCrossFade(
              firstChild: Text(
                'Discover',
                style: Theme.of(context).textTheme.headline2,
              ),
              secondChild: const SizedBox(),
              crossFadeState: isClosed
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300)),
          pinned: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text('Discover',
                      style: Theme.of(context).textTheme.headline1),
                  const NewsSearchInput()
                ],
              ),
            ),
          ),
        ),
        FutureBuilder(
            future: NewsDataUse(client: HttpClient()).getCountryNews('us'),
            builder: (context, AsyncSnapshot<List<NewsModel>> async) {
              if (async.hasData && async.data!.isNotEmpty) {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  if (async.data![index].urlToImage != '') {
                    return NewsItemsWidget(news: async.data![index]);
                  } else {
                    return null;
                  }
                }, childCount: async.data!.length));
              } else {
                return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Container();
                }, childCount: 0));
              }
            })
      ],
    );
  }
}

class NewsItemsWidget extends StatelessWidget {
  NewsItemsWidget({Key? key, required this.news}) : super(key: key);
  NewsModel news;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          CupertinoPageRoute(builder: (context) => NewsFullPage(news: news))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  news.title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 5,
                  child: Image.network(
                    news.urlToImage,
                    fit: BoxFit.fitWidth,
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 0)
        ],
      ),
    );
  }
}

class NewsSearchInput extends StatelessWidget {
  const NewsSearchInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 9,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const TextField(
        maxLines: null,
        minLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Chats, channels and peoples...',
        ),
      ),
    );
  }
}

class NewsFullPage extends StatefulWidget {
  const NewsFullPage({Key? key, required this.news}) : super(key: key);
  final NewsModel news;

  @override
  State<NewsFullPage> createState() => _NewsFullPageState();
}

class _NewsFullPageState extends State<NewsFullPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final PageController _controller = PageController();
  bool isClosed = false;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      isClosed = _isSliverAppBarExpanded;
      setState(() {});
    });
  }

  bool get _isSliverAppBarExpanded {
    return _controller.hasClients &&
        _controller.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            title: isClosed
                ? Text(widget.news.title,
                    style: Theme.of(context).textTheme.headline2)
                : null,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(4, 0, 0, 4),
              title: isClosed
                  ? null
                  : Text(
                      widget.news.title,
                      style: const TextStyle(fontSize: 13),
                    ),
              background:
                  Image.network(widget.news.urlToImage, fit: BoxFit.cover),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              ...List.generate(15, (index) => Text(widget.news.content)),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Published at : ' +
                        widget.news.publishedAt
                            .toLocal()
                            .toString()
                            .split(' ')[0])),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 10),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Author : ' +
                        (widget.news.author == ''
                            ? widget.news.urlToNews
                            : widget.news.author))),
              )
            ],
          ))
        ],
      ),
    );
  }
}
