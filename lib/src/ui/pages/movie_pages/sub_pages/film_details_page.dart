import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smessanger/src/bloc/films_bloc/details_page_bloc/film_details_bloc.dart';
import 'package:smessanger/src/bloc/films_bloc/details_page_bloc/film_details_state.dart';
import 'package:smessanger/src/models/films_model.dart';
import 'package:smessanger/src/models/movie_details_model.dart';
import 'package:smessanger/src/resources/domain/repositories/films_repositories/films_repository.dart';
import 'package:smessanger/injections.dart' as rep;
import 'package:smessanger/src/ui/pages/movie_pages/sub_pages/trailer_page.dart';
import 'package:smessanger/src/ui/styles/images.dart';

import '../films_page.dart';

class FilmDetailsPage extends StatelessWidget {
  const FilmDetailsPage({Key? key, required this.film, required this.region})
      : super(key: key);
  final FilmsModel film;
  final String region;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilmDetailsBloc>(
      create: (context) => FilmDetailsBloc(
          filmId: film.id, domain: rep.sl.call<FilmsDomain>(), region: region),
      child: Scaffold(body: _FilmDetailsPage(film: film)),
    );
  }
}

class _FilmDetailsPage extends StatelessWidget {
  const _FilmDetailsPage({Key? key, required this.film}) : super(key: key);
  final FilmsModel film;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmDetailsBloc, FilmDetailsState>(
        builder: (context, state) {
      if (state is FilmDetailsLoaded) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilmDetailsHeader(film: film),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 0),
                child: Text((state.details.title),
                    style: Theme.of(context).textTheme.headline3),
              ),
              const RaitingAndTrailerWidget(),
              const FilmDetailsTitle(),
              const OverViewWidget()
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}

class FilmDetailsHeader extends StatelessWidget {
  const FilmDetailsHeader({Key? key, required this.film}) : super(key: key);
  final FilmsModel film;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.3,
      child: Stack(
        children: [
          SizedBox.expand(
            child: FadeInImage(
                placeholder: const AssetImage(AppImages.loading),
                image: NetworkImage(film.backdropPath ?? film.posterPath!)),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, color: Theme.of(context).colorScheme.primary),
              ),
              margin: const EdgeInsets.only(left: 30),
              height: 150,
              width: 100,
              child: FilmPhotoHeroWidget(
                url: (film.posterPath ?? film.backdropPath!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilmDetailsTitle extends StatelessWidget {
  const FilmDetailsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilmDetailsBloc, FilmDetailsState>(
        builder: (context, state) {
      if (state is FilmDetailsLoaded) {
        final hours = state.details.runtime ~/ 60;
        final minutes = state.details.runtime - hours * 60;
        final DateTime time = DateTime.parse(state.details.releaseDate);
        final String date = DateFormat('dd/MM/yyyy').format(time);
        final janres =
            state.details.genres.map((e) => e.name).toList().join(', ');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
              child: Center(
                child: Text(
                  '$date ● $hours\h $minutes\m\n$janres',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ],
        );
      } else {
        return Container(color: Colors.black);
      }
    });
  }
}

class RaitingAndTrailerWidget extends StatelessWidget {
  const RaitingAndTrailerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: MediaQuery.of(context).size.width / 8,
                  child: BlocBuilder<FilmDetailsBloc, FilmDetailsState>(
                      builder: (context, state) {
                    final mystate = state as FilmDetailsLoaded;

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox.expand(
                          child: CustomPaint(
                            painter: RatingPainter(
                                rating: state.details.voteAvergane,
                                backGroundColor:
                                    Theme.of(context).dialogBackgroundColor),
                          ),
                        ),
                        Text('${state.details.voteAvergane}')
                      ],
                    );
                  }),
                ),
                const SizedBox(width: 15),
                Text(
                  'User score',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 9,
            child: const VerticalDivider(),
          ),
          BlocBuilder<FilmDetailsBloc, FilmDetailsState>(
              builder: (context, state) {
            final mystate = state as FilmDetailsLoaded;
            return Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (myContext) =>
                          TrailerViewPage(url: state.trailers.first.key),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.play_arrow),
                    Text('Play trailer')
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class RatingPainter extends CustomPainter {
  final Color backGroundColor;
  final double rating;
  RatingPainter({required this.backGroundColor, required this.rating});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPainter = Paint();
    backgroundPainter.color = backGroundColor;
    backgroundPainter.style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPainter);

    final Paint secondPainter = Paint();
    secondPainter.color = getColor(rating);
    secondPainter.style = PaintingStyle.stroke;
    secondPainter.strokeWidth = 4;
    canvas.drawArc(const Offset(2, 2) & Size(size.width - 4, size.height - 4),
        -pi / 2, pi * 2 * (rating / 10), false, secondPainter);
  }

  @override
  bool shouldRepaint(RatingPainter oldDelegate) {
    return false;
  }

  @override
  bool shouldRebuildSemantics(RatingPainter oldDelegate) {
    return false;
  }

  Color getColor(double rating) {
    if (rating > 7) {
      return Colors.green;
    } else if (rating > 5) {
      return Colors.yellow;
    }
    return Colors.red;
  }
}

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Overview', style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 15),
          BlocBuilder<FilmDetailsBloc, FilmDetailsState>(
              builder: (context, state) {
            return Text(
              (state as FilmDetailsLoaded).details.overView,
              style: Theme.of(context).textTheme.bodyText1,
            );
          }),
        ],
      ),
    );
  }
}
