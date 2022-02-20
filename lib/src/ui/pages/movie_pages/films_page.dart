import 'package:flutter/cupertino.dart';
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
import 'package:smessanger/src/ui/styles/images.dart';

import 'sub_pages/film_details_page.dart';
import 'sub_pages/search_page.dart';

class FilmsMainPage extends StatelessWidget {
  const FilmsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.status == HomeStatus.loaded) {
        return BlocProvider<FilmsBloc>(
          create: (_) => FilmsBloc(
            filmsDomain: rep.sl.call(),
            gettedregion: state.myProfile!.countryCode,
          ),
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
                    enabled: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, firstAnim, secondAnim) {
                            return const FilmsSearchPage();
                          },
                        ),
                      );
                    },
                    text: 'Films, serials and actors...',
                  )
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
          if (state is FilmsLoadedState) {
            return FilmsBody(
              trandingFilms: state.popularityFilms,
              popularityFilms: state.trandingFilms,
            );
          } else if (state is FilmsLoadingState) {
            return SliverList(
              delegate: SliverChildListDelegate.fixed([
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ]),
            );
          } else {
            state as FilmsLoadingStateError;
            return SliverList(
              delegate: SliverChildListDelegate.fixed([
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.error, color: Colors.white),
                      const SizedBox(height: 20),
                      const Text('No connection'),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () =>
                              BlocProvider.of<FilmsBloc>(context).loadFilms(),
                          icon: Icon(Icons.refresh,
                              color: Theme.of(context).backgroundColor),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            );
          }
        })
      ],
    );
  }
}

class FilmsBody extends StatelessWidget {
  const FilmsBody(
      {Key? key, required this.popularityFilms, required this.trandingFilms})
      : super(key: key);
  final List<FilmsModel> popularityFilms;
  final List<FilmsModel> trandingFilms;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        MainFilmsList(
          films: popularityFilms,
          text: 'Popularity',
        ),
        MainFilmsList(
          films: trandingFilms,
          text: 'Tranding',
        ),
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
                              CupertinoPageRoute(
                                builder: (mycontext) => FilmDetailsPage(
                                  id: film.id,
                                  region: BlocProvider.of<HomeBloc>(context)
                                          .state
                                          .myProfile
                                          ?.countryCode ??
                                      'rus',
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
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
