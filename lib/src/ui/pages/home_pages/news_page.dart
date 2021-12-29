import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Discover', style: Theme.of(context).textTheme.headline2),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
              margin: const EdgeInsets.all(5),
              color: Colors.black,
              width: double.infinity,
              height: 100,
            );
          }, childCount: 15),
        )
      ],
    );
  }
}
