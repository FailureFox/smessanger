class FilmsModel {
  final bool? adult;
  final String? backdropPath;
  final List<int> genreId;
  final int id;
  final String language;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  FilmsModel({
    required this.adult,
    required this.backdropPath,
    required this.genreId,
    required this.id,
    required this.language,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory FilmsModel.fromMap(Map<String, dynamic> map) {
    return FilmsModel(
      adult: map['adult'],
      backdropPath: map['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/original' + map['backdrop_path']
          : null,
      genreId: (map['genre_ids'] as List).map((e) => e as int).toList(),
      id: map['id'],
      language: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500' + map['poster_path']
          : null,
      releaseDate: map['release_date'],
      title: map['title'],
      video: map['video'],
      voteAverage: double.parse("${map['vote_average']}"),
      voteCount: map['vote_count'],
    );
  }
}
