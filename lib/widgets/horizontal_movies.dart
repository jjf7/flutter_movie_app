import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class HorizontalMovies extends StatefulWidget {
  final List<Movie> popularMovies;
  final Function onNextPage;
  final String header;

  const HorizontalMovies(
      {super.key,
      required this.popularMovies,
      required this.onNextPage,
      required this.header});

  @override
  State<HorizontalMovies> createState() => _HorizontalMoviesState();
}

class _HorizontalMoviesState extends State<HorizontalMovies> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text("Populares",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.popularMovies.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      width: 130,
                      child: _Card(widget.popularMovies[index],
                          'popular-${widget.popularMovies[index].id}-${widget.popularMovies[index].title}'),
                    );
                  }),
            ),
          ],
        ));
  }
}

class _Card extends StatelessWidget {
  final Movie movie;
  final String heroId;
  const _Card(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
      child: Column(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.urlImg),
                  height: 160,
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
