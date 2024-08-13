// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'movie_detail.dart';
import 'movie.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late HttpHelper helper; // Helper for making HTTP requests
  List<Movie> movies = []; // List to store fetched movies
  int moviesCount = 0; // Number of movies in the list
  Icon visibleIcon = Icon(Icons.search); // Icon for search button
  Widget searchBar = Text('Movies'); // Title or search bar widget

  @override
  void initState() {
    super.initState();
    helper = HttpHelper(); // Initialize HTTP helper
    initialize(); // Fetch initial list of movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: searchBar, // Display the search bar or title
        actions: <Widget>[
          IconButton(
            icon: visibleIcon, // Toggle between search and cancel icons
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = Icon(Icons.cancel); // Change icon to cancel
                  searchBar = TextField(
                    textInputAction: TextInputAction.search, // Trigger search on submit
                    onSubmitted: (String text) {
                      search(text); // Perform search with the input text
                    },
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                  );
                } else {
                  visibleIcon = Icon(Icons.search); // Change icon to search
                  searchBar = Text('Movies'); // Reset to title
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: moviesCount, // Number of items in the list
        itemBuilder: (context, position) {
          final movie = movies[position];
          final imageUrl = movie.posterPath.isNotEmpty
              ? movie.posterPath
              : 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg'; // Default placeholder image
          final image = NetworkImage(imageUrl) as ImageProvider;

          return Card(
            color: Colors.white, // Background color of the card
            elevation: 2.0, // Shadow elevation of the card
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MovieDetail(movie)), // Navigate to movie detail page
                );
              },
              leading: CircleAvatar(
                backgroundImage: image, // Display movie poster
              ),
              title: Text(movie.title), // Movie title
              subtitle: Text('Released: ${movie.releaseDate} - IMDb Rating: ${movie.imdbRating}'), // Movie details
            ),
          );
        },
      ),
    );
  }

  // Initialize the list of movies with a default search
  Future initialize() async {
    try {
      List<Movie> fetchedMovies = await helper.findMovies('Avengers'); // Fetch movies with the title 'Avengers'
      setState(() {
        movies = fetchedMovies;
        moviesCount = movies.length;
      });
    } catch (e) {
      // Handle error as needed
    }
  }

  // Search for movies based on user input
  Future search(String text) async {
    try {
      List<Movie> searchedMovies = await helper.findMovies(text); // Fetch movies based on the search text
      setState(() {
        movies = searchedMovies;
        moviesCount = movies.length;
      });
    } catch (e) {
      // Handle error as needed
    }
  }
}
