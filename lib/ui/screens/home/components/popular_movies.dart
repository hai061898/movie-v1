import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/bloc/popular_movies_bloc/popular_movies_cubit.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/widgets/movie_list_loading.dart';
import 'package:movie/ui/widgets/movies_list_horizontal.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);

  final MovieController movieController;
  final MovieService movieService;

  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieService,
      child: PopularMoviesList(
        movieController: widget.movieController,
        movieService: widget.movieService,
      ),
    );
  }
}

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularMovieCubit(
        movieService: context.read<MovieService>(),
      )..fetchList(),
      child: PopularMovieView(
        movieController: movieController,
        movieService: movieService,
      ),
    );
  }
}

class PopularMovieView extends StatelessWidget {
  const PopularMovieView(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PopularMovieCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        if (state.movies.isEmpty) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      "No More Popular Movies",
                      style: TextStyle(color: Colors.black45),
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return MoviesListHorizontal(
            movies: state.movies,
            movieService: movieService,
            movieController: movieController,
          );
        }
      default:
        return buildMovielistLoaderWidget(context);
    }
  }
}
