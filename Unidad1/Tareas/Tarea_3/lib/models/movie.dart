/// Represents the structure of a movie obtained from the API.
class Movie {
  final String title;
  final String overview;
  final String releaseDate;
  final double voteAverage;

  Movie({
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
  });

  /// Factory constructor to create a Movie instance from a JSON map.
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview',
      releaseDate: json['release_date'] ?? 'Unknown Date',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
    );
  }

  /// Converts the Movie instance to a map for serialization.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'overview': overview,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
    };
  }
}
