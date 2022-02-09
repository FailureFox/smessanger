import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/films_bloc.dart';
import 'package:smessanger/injections.dart' as rep;
import 'package:smessanger/src/bloc/films_bloc/films_state.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';
import 'package:smessanger/src/models/films_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smessanger/src/ui/pages/home_pages/news_page.dart';

class FilmsMainPage extends StatelessWidget {
  const FilmsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.status == HomeStatus.loaded) {
        return BlocProvider<FilmsBloc>(
          create: (_) => FilmsBloc(
              filmsDomain: rep.sl.call(), region: state.myProfile!.countryCode),
          child: const SecondFilmsBody(),
        );
      } else {
        return Container();
      }
    });
  }
}

class SecondFilmsBody extends StatefulWidget {
  const SecondFilmsBody({Key? key}) : super(key: key);

  @override
  State<SecondFilmsBody> createState() => SecondFilmsBodyState();
}

class SecondFilmsBodyState extends State<SecondFilmsBody> {
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
      controller: _controller,
      slivers: [
        SliverAppBar(
          centerTitle: true,
          pinned: true,
          title: AnimatedCrossFade(
              firstChild: Text(
                'Movies',
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
                  Text('Movies', style: Theme.of(context).textTheme.headline1),
                  SearchInput(
                    onTap: () {},
                    text: 'Films, serials and actors...',
                  )
                ],
              ),
            ),
          ),
        ),
        const FilmsBody()
      ],
    );
  }
}

class FilmsBody extends StatelessWidget {
  const FilmsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
          return MainFilmsList(
            films: state.popularityFilms,
            text: 'Popularity',
          );
        }),
        BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
          return MainFilmsList(
            films: state.trandingFilms,
            text: 'Tranding',
          );
        }),
      ]),
    );
  }
}

class MainFilmsList extends StatelessWidget {
  const MainFilmsList({Key? key, required this.films, required this.text})
      : super(key: key);
  final List<FilmsModel> films;
  final String text;
  @override
  Widget build(BuildContext context) {
    final Key key = UniqueKey();

    return BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.width / 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                        fontFamily:
                            Theme.of(context).textTheme.headline1!.fontFamily,
                        fontSize: 25,
                        color: Theme.of(context).textTheme.headline1!.color),
                  ),
                  TextButton(onPressed: () {}, child: const Text('See all'))
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return PopularityFilmsWidget(
                    film: films[index],
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class PopularityFilmsWidget extends StatelessWidget {
  const PopularityFilmsWidget(
      {Key? key, required this.film, required this.index})
      : super(key: key);
  final FilmsModel film;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width / 2.5,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            height: MediaQuery.of(context).size.width / 1.5,
            child: film.posterPath != null || film.backdropPath != null
                ? Stack(
                    children: [
                      SizedBox.expand(
                          child: FilmPhotoHeroWidget(
                              url: film.posterPath ?? film.backdropPath!)),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FilmDetailsPage(film: film),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )
                : null,
          ),
          const SizedBox(height: 10),
          Text(film.title,
              style: Theme.of(context).textTheme.headline2, maxLines: 2),
        ],
      ),
    );
  }
}

class FilmPhotoHeroWidget extends StatelessWidget {
  const FilmPhotoHeroWidget({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheKey: url,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

class FilmDetailsPage extends StatelessWidget {
  const FilmDetailsPage({Key? key, required this.film}) : super(key: key);
  final FilmsModel film;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: film.backdropPath != null
                ? DecorationImage(image: NetworkImage(film.backdropPath!))
                : null,
          ),
          height: MediaQuery.of(context).size.width / 1.3,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 100,
              width: 50,
              child: FilmPhotoHeroWidget(
                url: (film.posterPath ?? film.backdropPath!),
              ),
            ),
          ),
        )
      ],
    );
  }
}
