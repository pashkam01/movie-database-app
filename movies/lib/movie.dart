class Movie {
  final String title; // Title of the movie
  final String releaseDate; // Release date of the movie
  final double imdbRating; // IMDb rating of the movie
  final String posterPath; // URL to the movie poster image
  final String overview; // Plot overview of the movie
  final String genre; // Genre of the movie
  final String director; // Director of the movie
  final String writer; // Writer of the movie
  final String actors; // Actors in the movie
  final String runtime; // Runtime of the movie
  final String language; // Language of the movie
  final String country; // Country of origin of the movie
  final String awards; // Awards won by the movie

  // Constructor to initialize a Movie object with default values for optional fields
  Movie({
    required this.title,
    required this.releaseDate,
    required this.imdbRating,
    required this.posterPath,
    required this.overview,
    this.genre = 'N/A',
    this.director = 'N/A',
    this.writer = 'N/A',
    this.actors = 'N/A',
    this.runtime = 'N/A',
    this.language = 'N/A',
    this.country = 'N/A',
    this.awards = 'N/A',
  });

  // Factory constructor to create a Movie object from a JSON map
  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    return Movie(
      title: parsedJson['Title'] ?? 'Unknown Title',
      releaseDate: parsedJson['Released'] ?? 'Unknown Release Date',
      imdbRating: double.tryParse(parsedJson['imdbRating']?.toString() ?? '0') ?? 0.0,
      posterPath: parsedJson['Poster'] ?? '',
      overview: parsedJson['Plot'] ?? 'No Overview Available',
      genre: parsedJson['Genre'] ?? 'N/A',
      director: parsedJson['Director'] ?? 'N/A',
      writer: parsedJson['Writer'] ?? 'N/A',
      actors: parsedJson['Actors'] ?? 'N/A',
      runtime: parsedJson['Runtime'] ?? 'N/A',
      language: parsedJson['Language'] ?? 'N/A',
      country: parsedJson['Country'] ?? 'N/A',
      awards: parsedJson['Awards'] ?? 'N/A',
    );
  }
}
