import 'package:flutter/material.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/data/services/movie_service.dart';

import 'package:movie/ui/screens/details/components/movie_detail.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen(
      {Key? key,
      required this.movieId,
      required this.movieController,
      required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return MovieDetailWidget(
      movieId: movieId,
      movieService: movieService,
      movieController: movieController,
    );
  }
}


