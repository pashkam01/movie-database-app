// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie; // Movie object passed to this widget

  const MovieDetail(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    // Use movie.posterPath directly, ensuring it's a valid URL
    final posterUrl = movie.posterPath.isNotEmpty
        ? movie.posterPath
        : 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg'; // Default poster URL

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title), // AppBar title with movie title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Display the movie poster
              Center(
                child: Image.network(
                  posterUrl,
                  height: MediaQuery.of(context).size.height / 3, // Set height relative to screen size
                  fit: BoxFit.cover, // Ensure the image covers the area
                ),
              ),
              SizedBox(height: 16.0), // Space between the poster and the text

              // Display movie details
              Text(
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Title style
              ),
              SizedBox(height: 8.0), // Space between title and release date
              if (movie.releaseDate.isNotEmpty) ...[
                Text(
                  'Released: ${movie.releaseDate}',
                  style: TextStyle(fontSize: 18), // Style for release date
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.imdbRating > 0) ...[
                Text(
                  'IMDb Rating: ${movie.imdbRating}',
                  style: TextStyle(fontSize: 18), // Style for IMDb rating
                ),
                SizedBox(height: 16.0),
              ],

              // Display additional movie details only if they are not empty
              if (movie.genre.isNotEmpty) ...[
                Text(
                  'Genre: ${movie.genre}',
                  style: TextStyle(fontSize: 16), // Style for genre
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.director.isNotEmpty) ...[
                Text(
                  'Director: ${movie.director}',
                  style: TextStyle(fontSize: 16), // Style for director
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.writer.isNotEmpty) ...[
                Text(
                  'Writer: ${movie.writer}',
                  style: TextStyle(fontSize: 16), // Style for writer
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.actors.isNotEmpty) ...[
                Text(
                  'Actors: ${movie.actors}',
                  style: TextStyle(fontSize: 16), // Style for actors
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.runtime.isNotEmpty) ...[
                Text(
                  'Runtime: ${movie.runtime}',
                  style: TextStyle(fontSize: 16), // Style for runtime
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.language.isNotEmpty) ...[
                Text(
                  'Language: ${movie.language}',
                  style: TextStyle(fontSize: 16), // Style for language
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.country.isNotEmpty) ...[
                Text(
                  'Country: ${movie.country}',
                  style: TextStyle(fontSize: 16), // Style for country
                ),
                SizedBox(height: 8.0),
              ],
              if (movie.awards.isNotEmpty) ...[
                Text(
                  'Awards: ${movie.awards}',
                  style: TextStyle(fontSize: 16), // Style for awards
                ),
                SizedBox(height: 16.0),
              ],

              // Display movie plot/overview
              if (movie.overview.isNotEmpty) ...[
                Text(
                  'Plot:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Style for plot heading
                ),
                SizedBox(height: 8.0),
                Text(
                  movie.overview,
                  style: TextStyle(fontSize: 16), // Style for plot text
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
