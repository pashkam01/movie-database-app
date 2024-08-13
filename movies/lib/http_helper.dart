import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';

class HttpHelper {
  final String apiKey = '8f7ad4d8'; // Your actual API key for accessing the OMDb API
  final String baseUrl = 'http://www.omdbapi.com/'; // Base URL for the OMDb API

  // Method to create the search URL for querying movies by title
  String _buildSearchUrl(String title) {
    return '$baseUrl?s=${Uri.encodeComponent(title)}&apikey=$apiKey';
  }

  // Method to find movies based on the provided title
  Future<List<Movie>> findMovies(String title) async {
    try {
      // Create the query URI using the search URL method
      final Uri queryUri = Uri.parse(_buildSearchUrl(title));
      
      // Send a GET request to the OMDb API
      http.Response result = await http.get(queryUri);

      // Check if the response status code is OK (200)
      if (result.statusCode == HttpStatus.ok) {
        // Decode the JSON response
        final jsonResponse = json.decode(result.body);
        
        // Check if the response indicates success
        if (jsonResponse['Response'] == 'True') {
          final moviesList = jsonResponse['Search']; // Extract the list of movies
          List<Movie> movies = [];

          // Iterate over the list of movies
          for (var movieJson in moviesList) {
            final movieId = movieJson['imdbID']; // Get the IMDb ID for each movie
            final movieDetails = await _fetchMovieDetails(movieId); // Fetch detailed information for the movie
            movies.add(movieDetails); // Add the movie details to the list
          }

          return movies; // Return the list of movies
        }
      }
    } catch (e) {
      // Handle any errors that occur during the request
      // You may want to log the error or show a user-friendly message
    }
    
    // Return an empty list if no movies are found or if an error occurs
    return [];
  }

  // Method to fetch detailed information about a movie by its IMDb ID
  Future<Movie> _fetchMovieDetails(String imdbID) async {
    try {
      // Create the details URI for fetching movie details
      final Uri detailsUri = Uri.parse('$baseUrl?i=$imdbID&apikey=$apiKey');
      
      // Send a GET request to the OMDb API for movie details
      final http.Response result = await http.get(detailsUri);

      // Check if the response status code is OK (200)
      if (result.statusCode == HttpStatus.ok) {
        // Decode the JSON response
        final jsonResponse = json.decode(result.body);
        
        // Check if the response indicates success
        if (jsonResponse['Response'] == 'True') {
          return Movie.fromJson(jsonResponse); // Return a Movie object created from the JSON response
        }
      }
    } catch (e) {
      // Handle any errors that occur during the request
      // You may want to log the error or show a user-friendly message
    }
    
    // Return a default movie object if details are not found or if an error occurs
    return Movie(
      title: 'Unknown Title',
      releaseDate: 'Unknown Release Date',
      imdbRating: 0.0,
      posterPath: '',
      overview: 'No Overview Available',
    );
  }
}
