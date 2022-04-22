import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/bloc/similar_movies_bloc/similar_movies_cubit.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/widgets/movie_list_loading.dart';
import 'package:movie/ui/widgets/movies_list_horizontal.dart';

class SimilarMoviesWidget extends StatelessWidget {
  const SimilarMoviesWidget(
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
    return BlocProvider(
      create: (_) => SimilarMoviesCubit(
        movieService: context.read<MovieService>(),
      )..fetchList(movieId),
      child: SimilarMoviesList(
        movieId: movieId,
        movieService: movieService,
        movieController: movieController,
      ),
    );
  }
}

class SimilarMoviesList extends StatelessWidget {
  const SimilarMoviesList(
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
    final state = context.watch<SimilarMoviesCubit>().state;

    switch (state.status) {
      case ListStatus.failure:
        return const Center(
            child: Text(
          'Oops something went wrong!',
          style: TextStyle(color: Colors.white),
        ));
      case ListStatus.success:
        return MoviesListHorizontal(
          movies: state.movies,
          movieService: movieService,
          movieController: movieController,
        );
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
