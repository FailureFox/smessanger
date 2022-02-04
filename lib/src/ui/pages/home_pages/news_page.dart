import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/news_bloc/news_bloc.dart';
import 'package:smessanger/src/bloc/news_bloc/news_event.dart';
import 'package:smessanger/src/bloc/news_bloc/news_state.dart';
import 'package:smessanger/src/bloc/news_bloc/news_status.dart';
import 'package:smessanger/src/resources/data/news_data.dart';
import 'package:smessanger/src/ui/pages/home_pages/components/news_items_widget.dart';
import 'package:smessanger/src/ui/styles/images.dart';
import 'package:smessanger/injections.dart' as rep;

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NewsBloc(newsData: rep.sl.call<NewsData>()),
        child: const _NewsPageWithBloc());
  }
}

class _NewsPageWithBloc extends StatefulWidget {
  const _NewsPageWithBloc({Key? key}) : super(key: key);

  @override
  State<_NewsPageWithBloc> createState() => _NewsPageWithBlocState();
}

class _NewsPageWithBlocState extends State<_NewsPageWithBloc> {
  final ScrollController _controller = ScrollController();
  bool isClosed = false;
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(NewsLoadingEvent());
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
                  const SearchInput()
                ],
              ),
            ),
          ),
          const NewsBody()
        ],
      ),
    );
  }
}

class NewsBody extends StatelessWidget {
  const NewsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'In case if you missed it',
                style: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline1!.fontFamily,
                    fontSize: 25,
                    color: Theme.of(context).textTheme.headline1!.color),
              ),
              TextButton(onPressed: () {}, child: const Text('See all')),
            ],
          ),
          BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
            if (state.status == NewsStatus.loaded) {
              return Column(
                children: List.generate(
                  5,
                  (index) => NewsItemsWidget(
                    news: state.news[index],
                  ),
                ),
              );
            } else {
              return Column(
                  children: List.generate(
                      5, (index) => const NewsItemsLoadingWidget()));
            }
          }),
          const SizedBox(height: 30),
          const HomeCategoriesWidget(),
        ],
      ),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key}) : super(key: key);

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular categories',
              style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.headline1!.fontFamily,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.headline1!.color),
            ),
            TextButton(onPressed: () {}, child: const Text('See all'))
          ],
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
                text: 'Sciense',
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
