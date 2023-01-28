import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies/widgets/widgets.dart';
import '../models/models.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _CustomTitleAndImg(movie),
            _DescriptionAndCasting(movie),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '<Actores>',
              ),
            ),
            CastingSlider(idMovie: movie.id),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 300,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.backgroundImgMovie),
          fit: BoxFit.cover,
        ),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _CustomTitleAndImg extends StatelessWidget {
  final Movie movie;
  const _CustomTitleAndImg(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.urlImg),
                fit: BoxFit.cover,
                height: 160,
                width: 130,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline5,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_border_purple500, size: 21),
                    const SizedBox(width: 10),
                    Text('${movie.voteAverage}',
                        style: Theme.of(context).textTheme.headline6),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _DescriptionAndCasting extends StatelessWidget {
  final Movie movie;
  const _DescriptionAndCasting(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(movie.overview,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 20,
            )));
  }
}
