import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smessanger/src/models/news_model.dart';

import 'package:smessanger/src/resources/data/news_data_use.dart';
import 'package:smessanger/src/ui/pages/home_pages/components/news_items_widget.dart';
import 'package:smessanger/src/ui/styles/images.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomScrollView(
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
              background: Column(
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
          // FutureBuilder(
          //     future: NewsDataUse().getCountryNews('us'),
          //     builder: (context, AsyncSnapshot<List<NewsModel>> async) {
          //       if (async.hasData && async.data!.isNotEmpty) {
          //         return SliverList(
          //             delegate: SliverChildListDelegate([
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Text(
          //                 'In case if you missed it',
          //                 style: TextStyle(
          //                     fontFamily: Theme.of(context)
          //                         .textTheme
          //                         .headline1!
          //                         .fontFamily,
          //                     fontSize: 25,
          //                     color:
          //                         Theme.of(context).textTheme.headline1!.color),
          //               ),
          //               TextButton(
          //                   onPressed: () {}, child: const Text('See all')),
          //             ],
          //           ),
          //           ...List.generate(5,
          //               (index) => NewsItemsWidget(news: async.data![index])),
          //           const SizedBox(height: 30),
          //           const HomeCategoriesWidget(),
          //         ]));
          //       } else {
          //         return SliverList(
          //             delegate: SliverChildBuilderDelegate((context, index) {
          //           return Container();
          //         }, childCount: 0));
          //       }
          //     })
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

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular categories',
          style: TextStyle(
              fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
              fontSize: 25,
              color: Theme.of(context).textTheme.headline1!.color),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              NewsCategoriesItemsWidget(
                image: AppImages.searching,
                text: 'Philosophy',
                members: '12,145',
              ),
              NewsCategoriesItemsWidget(
                image: AppImages.loading,
                text: 'Books',
                members: '12,145',
              ),
              NewsCategoriesItemsWidget(
                image: AppImages.teamwork,
                text: 'Sport',
                members: '12,145',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class NewsCategoriesItemsWidget extends StatelessWidget {
  const NewsCategoriesItemsWidget({
    Key? key,
    required this.image,
    required this.members,
    required this.text,
  }) : super(key: key);
  final String image;
  final String members;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 5.4,
          width: MediaQuery.of(context).size.width / 1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                        colorFilter:
                            Theme.of(context).brightness == Brightness.dark
                                ? const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn)
                                : null),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(text, style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 5),
              Text('$members members'),
            ],
          )),
    );
  }
}
