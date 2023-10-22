//  respons dari API yang mengembalikan daftar film atau hasil pencarian film
class MovieResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

// untuk menampilkan list movie
class MovieModel {
  // final bool adult;
  final String backdropPath;
  // final List<int> genreIds;
  final int id;
  // final OriginalLanguage originalLanguage;
  // final String originalTitle;
  final String overview;
  // final double popularity;
  final String posterPath;
  // final DateTime releaseDate;
  final String title;
  // final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    // required this.adult,
    required this.backdropPath,
    // required this.genreIds,
    required this.id,
    // required this.originalLanguage,
    // required this.originalTitle,
    required this.overview,
    // required this.popularity,
    required this.posterPath,
    // required this.releaseDate,
    required this.title,
    // required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        // adult: json["adult"],
        backdropPath: json["backdrop_path"],
        // genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        // originalLanguage:
        //     originalLanguage: [json["original_language"]]!,
        // originalTitle: json["original_title"],
        overview: json["overview"],
        // popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        // releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        // video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}
