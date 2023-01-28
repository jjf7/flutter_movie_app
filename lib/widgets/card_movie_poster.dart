import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class CardMoviePoster extends StatelessWidget {
  final List<Movie> movies;
  const CardMoviePoster({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (movies.length == 0) {
      return Container(
        height: size.height * 0.6,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: _CardSwiper(movies),
      ),
    );
  }
}

class _CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const _CardSwiper(this.movies);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Swiper(
      itemCount: movies.length,
      layout: SwiperLayout.STACK,
      itemWidth: size.width * 0.6,
      itemHeight: size.height * 0.5,
      itemBuilder: (context, index) {
        movies[index].heroId = 'Swiper-${movies[index].id}';
        return GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movies[index]),
          child: Hero(
            tag: movies[index].heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movies[index].urlImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
