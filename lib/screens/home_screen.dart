import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context);

    final List<Movie> popularMovies = moviesProvider.listPopularMovies;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Listado de peliculas por Jose Fuentes. (Flutter)",
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MovieSearchDelegate());
              },
              icon: const Icon(Icons.search_off_outlined))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          CardMoviePoster(movies: moviesProvider.listMovies),
          HorizontalMovies(
            popularMovies: popularMovies,
            onNextPage: () => moviesProvider.getPopularMovies(),
            header: 'Pupulares',
          ),
        ],
      )),
    );
  }
}
