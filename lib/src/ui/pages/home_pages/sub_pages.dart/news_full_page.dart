import 'package:flutter/material.dart';
import 'package:smessanger/src/models/news_model.dart';

class NewsFullPage extends StatefulWidget {
  const NewsFullPage({Key? key, required this.news}) : super(key: key);
  final NewsModel news;

  @override
  State<NewsFullPage> createState() => _NewsFullPageState();
}

class _NewsFullPageState extends State<NewsFullPage> {
  @override
  void dispose() {
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
              background:
                  Image.network(widget.news.urlToImage, fit: BoxFit.cover),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  widget.news.title,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
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
                  child: Text(
                    'Author : ' +
                        (widget.news.author == ''
                            ? widget.news.urlToNews
                            : widget.news.author),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
