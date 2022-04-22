import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/screens/details/components/movie_detail_view.dart';

class MovieDetailWidget extends StatefulWidget {
  const MovieDetailWidget(
      {Key? key,
      required this.movieId,
      required this.movieController,
      required this.movieService})
      : super(key: key);

  final MovieController movieController;
  final MovieService movieService;
  final int movieId;

  @override
  _MovieDetailWidgetState createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieService,
      child: MovieDetailView(
        movieController: widget.movieController,
        movieService: widget.movieService,
        movieId: widget.movieId,
      ),
    );
  }
}
