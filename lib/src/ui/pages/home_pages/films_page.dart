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
        Text('123', style: Theme.of(context).textTheme.headline1),
        BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
          return MainFilmsList(films: state.popularityFilms);
        }),
        BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
          return MainFilmsList(films: state.trandingFilms);
        }),
      ],
    );
  }
}

class MainFilmsList extends StatelessWidget {
  const MainFilmsList({Key? key, required this.films}) : super(key: key);
  final List<FilmsModel> films;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmsBloc, FilmsState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.width / 1.1,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: films.length,
          itemBuilder: (context, index) {
            return PopularityFilmsWidget(
              film: films[index],
            );
          },
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
                ? Image.network(film.posterPath ?? film.backdropPath!,
                    fit: BoxFit.fitHeight)
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
