import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  Widget _noResults() {
    return const Center(
      child: Icon(
        Icons.movie_filter,
        size: 150,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return _noResults();
    }

    final movieProvider = Provider.of<MovieProvider>(context);

    movieProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: movieProvider.suggestionStream,
      builder: ((_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _noResults();

        final List<Movie> movie = snapshot.data!;

        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (context, index) {
            return SizedBox(
                width: double.infinity,
                height: 100,
                child: _SearchItem(movie: movie[index]));
          },
        );
      }),
    );
  }
}

class _SearchItem extends StatelessWidget {
  final Movie movie;
  const _SearchItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
      child: Hero(
        tag: movie.heroId!,
        child: ListTile(
          leading: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.urlImg),
            fit: BoxFit.contain,
          ),
          title: Text(movie.title),
        ),
      ),
    );
  }
}
