import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smessanger/src/bloc/films_bloc/films_search_bloc/films_search_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/films_search_bloc/films_search_state.dart';
import 'package:smessanger/src/resources/domain/repositories/films_repositories/films_repository.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';
import 'package:smessanger/src/ui/pages/movie_pages/sub_pages/film_details_page.dart';
import 'package:smessanger/src/ui/styles/images.dart';
import 'package:smessanger/injections.dart' as rep;

class FilmsSearchPage extends StatelessWidget {
  const FilmsSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilmsSearchBloc>(
      create: (_) =>
          FilmsSearchBloc(region: 'us', domain: rep.sl.call<FilmsDomain>()),
      child: const FilmsSearchPageBody(),
    );
  }
}

class FilmsSearchPageBody extends StatefulWidget {
  const FilmsSearchPageBody({Key? key}) : super(key: key);

  @override
  State<FilmsSearchPageBody> createState() => _FilmsSearchPageBodyState();
}

class _FilmsSearchPageBodyState extends State<FilmsSearchPageBody> {
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
                      suffix: SizedBox(
                        height: 20,
                        width: 60,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              isExpanded: true,
                              value: 'All',
                              items:
                                  <String>['All', 'Movies', 'Actors', 'Serials']
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e),
                                            value: e,
                                          ))
                                      .toList(),
                              onChanged: (value) {}),
                        ),
                      ),
                      enabled: true,
                      onTap: () {},
                      onChanged: (text) {
                        if (text != lastInputValue) {
                          lastInputValue = text;
                          _onSearchChanged(
                            () {
                              BlocProvider.of<FilmsSearchBloc>(context)
                                  .searchFilms(text: text);
                            },
                          );
                        }
                      },
                      text: 'Films, serials and actors...',
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocBuilder<FilmsSearchBloc, FilmsSearchState>(
              builder: (context, state) {
            if (state is FilmsSearchLoading) {
              return FilmsSearchEmptyWidget(
                  whiteColor: Colors.black45,
                  darkColor: Colors.white54,
                  widget: Container(
                    width: MediaQuery.of(context).size.height / 20,
                    height: MediaQuery.of(context).size.height / 20,
                    margin: const EdgeInsets.all(20),
                    child: const CircularProgressIndicator(),
                  ),
                  image: AppImages.loading,
                  text: 'Loading...');
            } else if (state is FilmsSearchEmpty) {
              return const FilmsSearchEmptyWidget(
                image: AppImages.empty,
                whiteColor: Colors.black45,
                darkColor: Colors.white54,
                text: 'No data',
              );
            } else if (state is FilmsSearchLoaded) {
              return const SearchFilmsList();
            } else if (state is FilmsSearchInitial) {
              return const FilmsSearchEmptyWidget(
                whiteColor: Colors.black45,
                darkColor: Colors.white54,
                image: AppImages.searching,
                text: 'Search',
              );
            } else {
              return const FilmsSearchEmptyWidget(
                  whiteColor: Colors.black45,
                  darkColor: Colors.white54,
                  image: AppImages.error,
                  text: 'ERROR...');
            }
          })
        ],
      ),
    );
  }
}

class FilmsSearchEmptyWidget extends StatelessWidget {
  const FilmsSearchEmptyWidget({
    Key? key,
    required this.image,
    required this.text,
    this.darkColor,
    this.whiteColor,
    this.widget,
  }) : super(key: key);
  final String image;
  final String text;
  final Color? darkColor;
  final Color? whiteColor;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed(
        [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Image.asset(image,
                        fit: BoxFit.cover,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? darkColor
                            : whiteColor)),
                const SizedBox(height: 35),
                Text(text, style: const TextStyle(fontSize: 17)),
                if (widget != null) widget!,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchFilmsList extends StatelessWidget {
  const SearchFilmsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmsSearchBloc, FilmsSearchState>(
        builder: (context, state) {
      state as FilmsSearchLoaded;
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return SearchFilmsListItems(film: state.movies[index]);
        }, childCount: state.movies.length),
      );
    });
  }
}

class SearchFilmsListItems extends StatelessWidget {
  const SearchFilmsListItems({Key? key, required this.film}) : super(key: key);
  final FilmsSearchEntity film;
  @override
  Widget build(BuildContext context) {
    final dateTime = DateFormat('dd MMMM yyyy').format(film.releaseDate);
    return SizedBox(
      height: MediaQuery.of(context).size.height / 7,
      width: double.infinity,
      child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.06),
                  blurRadius: 5,
                  offset: Offset(0, 2)),
            ],
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Row(
                children: [
                  if (film.posterPath != null)
                    AspectRatio(
                      aspectRatio: 1 / 1.5,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500' + film.posterPath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 5, bottom: 5, right: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              film.title,
                              style: Theme.of(context).textTheme.headline2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(dateTime),
                            const Spacer(),
                            Text(film.overview,
                                maxLines: 2, textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                FilmDetailsPage(id: film.id, region: 'ru')));
                  },
                ),
              )
            ],
          )),
    );
  }
}
