import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/credits_movie_response.dart';

class CastingSlider extends StatelessWidget {
  final int idMovie;
  const CastingSlider({super.key, required this.idMovie});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return FutureBuilder(
      future: movieProvider.getListCastMovie(idMovie),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 220,
            child: Container(
                width: 5,
                child: const Center(child: CircularProgressIndicator())),
          );
        }

        final List<Cast> data = snapshot.data;

        return Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/no-image.jpg'),
                          image: NetworkImage(data[index].imgActor),
                          fit: BoxFit.cover,
                          height: 160,
                          width: 130,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data[index].name,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                  ],
                );
              },
            ));
        ;
      },
    );
  }
}
