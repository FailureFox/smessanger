import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smessanger/src/models/news_model.dart';
import 'package:smessanger/src/ui/pages/home_pages/sub_pages.dart/news_full_page.dart';

class NewsItemsWidget extends StatelessWidget {
  const NewsItemsWidget({Key? key, required this.news}) : super(key: key);
  final NewsModel news;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          CupertinoPageRoute(builder: (context) => NewsFullPage(news: news))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        maxLines: 3,
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(DateTime.now()
                              .difference(news.publishedAt)
                              .inHours
                              .toString() +
                          ' hours ago')
                    ],
                  ),
                ),
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

class NewsItemsLoadingWidget extends StatelessWidget {
  const NewsItemsLoadingWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer(child: Container(height: 10)),
                    const SizedBox(height: 5),
                    Shimmer(child: Container(height: 10)),
                    const SizedBox(height: 5),
                    Shimmer(child: Container(height: 10)),
                    const SizedBox(height: 10),
                    Shimmer(child: const SizedBox(height: 5, width: 30)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 5,
                  child: Shimmer(child: Container()))
            ],
          ),
        ),
        const Divider(height: 0)
      ],
    );
  }
}
