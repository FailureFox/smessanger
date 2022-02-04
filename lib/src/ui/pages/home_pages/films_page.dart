import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/films_bloc.dart';
import 'package:smessanger/injections.dart' as rep;
import 'package:smessanger/src/bloc/films_bloc/films_state.dart';
import 'package:smessanger/src/bloc/home_bloc/home_bloc.dart';
import 'package:smessanger/src/bloc/home_bloc/home_state.dart';
import 'package:smessanger/src/models/films_model.dart';

class FilmsMainPage extends StatelessWidget {
  const FilmsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state.status == HomeStatus.loaded) {
        return BlocProvider<FilmsBloc>(
            create: (_) => FilmsBloc(
                filmsDomain: rep.sl.call(),
                region: state.myProfile!.countryCode),
            child: const FilmsBody());
      } else {
        return Container();
      }
    });
  }
}

class FilmsBody extends StatelessWidget {
  const FilmsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
      ],
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
                        child: Image.network(
                            film.posterPath ?? film.backdropPath!,
                            fit: BoxFit.fitHeight),
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
            height: MediaQuery.of(context).size.width / 1.2 ,
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
