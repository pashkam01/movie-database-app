import 'package:flutter/material.dart';
import 'movie_list.dart';

// Entry point of the application
void main() => runApp(const MyMovies());

// Main application widget
class MyMovies extends StatelessWidget {
  const MyMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The title of the application
      title: 'My Movies',

      // Define the theme of the application
      theme: ThemeData(
        // Set the primary color theme
        primarySwatch: Colors.deepOrange,
      ),

      // Define the home screen of the application
      home: const Home(),
    );
  }
}

// Home screen widget
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Return the MovieList widget as the home screen
    return const MovieList();
  }
}
