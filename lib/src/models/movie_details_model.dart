import 'dart:convert';

class DetailsModel {
  final bool adult;
  final String? backdopPath;
  final int budget;
  final List<Genres> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overView;
  final double popularity;
  final String? posterPath;
  final List<ProductionsCompanies> productionCompanies;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tageLine;
  final String title;
  final bool video;
  final double voteAvergane;
  final int voteCount;

  DetailsModel({
    required this.adult,
    required this.backdopPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overView,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tageLine,
    required this.title,
    required this.video,
    required this.voteAvergane,
    required this.voteCount,
  });

  factory DetailsModel.fromJson(String source) =>
      DetailsModel.fromMap(json.decode(source));

  factory DetailsModel.fromMap(Map<String, dynamic> map) {
    return DetailsModel(
      adult: map['adult'] ?? false,
      backdopPath: map['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/original' + map['backdrop_path']
          : null,
      budget: map['budget']?.toInt() ?? 0,
      genres: List<Genres>.from(map['genres']?.map((x) => Genres.fromMap(x))),
      homepage: map['homepage'] ?? '',
      id: map['id']?.toInt() ?? 0,
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overView: map['overview'] ?? '',
      popularity: map['popularity']?.toDouble() ?? 0.0,
      posterPath: map['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500' + map['poster_path']
          : null,
      productionCompanies: List<ProductionsCompanies>.from(
          map['production_companies']
              ?.map((x) => ProductionsCompanies.fromMap(x))),
      releaseDate: map['release_date'] ?? '',
      revenue: map['revenue']?.toInt() ?? 0,
      runtime: map['runtime']?.toInt() ?? 0,
      status: map['status'] ?? '',
      tageLine: map['tageline'] ?? '',
      title: map['title'] ?? '',
      video: map['video'] ?? false,
      voteAvergane: map['vote_average']?.toDouble() ?? 0.0,
      voteCount: map['vote_count']?.toInt() ?? 0,
    );
  }
}

class ProductionsCompanies {
  final int id;
  final String? logoPath;
  final String name;
  final String country;
  ProductionsCompanies({
    required this.id,
    this.logoPath,
    required this.name,
    required this.country,
  });

  factory ProductionsCompanies.fromMap(Map<String, dynamic> map) {
    return ProductionsCompanies(
      id: map['id']?.toInt() ?? 0,
      logoPath: map['logo_path'],
      name: map['name'] ?? '',
      country: map['origin_country'] ?? '',
    );
  }

  factory ProductionsCompanies.fromJson(String source) =>
      ProductionsCompanies.fromMap(json.decode(source));
}

class ProductionCountries {
  final String name;
  final String iso;
  ProductionCountries({required this.name, required this.iso});

  factory ProductionCountries.fromMap(Map<String, dynamic> map) {
    return ProductionCountries(
      name: map['name'] ?? '',
      iso: map['iso_3166_1'] ?? '',
    );
  }

  factory ProductionCountries.fromJson(String source) =>
      ProductionCountries.fromMap(json.decode(source));
}

class Genres {
  final int id;
  final String name;
  Genres({required this.id, required this.name});

  factory Genres.fromMap(Map<String, dynamic> map) {
    return Genres(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  factory Genres.fromJson(String source) => Genres.fromMap(json.decode(source));
}
