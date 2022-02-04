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
  const PopularityFilmsWidget({Key? key, required this.film}) : super(key: key);
  final FilmsModel film;
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
                        child: CachedNetworkImage(
                          cacheKey: film.posterPath ?? film.backdropPath,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          imageUrl: film.posterPath ?? film.backdropPath!,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        // child: Image.network(
                        //     film.posterPath ?? film.backdropPath!,
                        //     fit: BoxFit.fitHeight),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleFilmPage(
                                  film: film,
                                ),
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

class SingleFilmPage extends StatelessWidget {
  const SingleFilmPage({Key? key, required this.film}) : super(key: key);
  final FilmsModel film;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.width / 1.2,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(film.backdropPath ?? film.posterPath!),
                  fit: BoxFit.fitHeight),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(film.title,
                    style: Theme.of(context).textTheme.headline1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
