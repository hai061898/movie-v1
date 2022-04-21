import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/bloc/top_rated_movies_bloc/top_rated_movies_cubit.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/widgets/movie_list_loading.dart';
import 'package:movie/ui/widgets/movies_list_horizontal.dart';

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  _TopRatedMoviesState createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieService,
      child: TopRatedMoviesList(
        movieController: widget.movieController,
        movieService: widget.movieService,
      ),
    );
  }
}

class TopRatedMoviesList extends StatelessWidget {
  const TopRatedMoviesList(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopRatedCubit(
        movieService: context.read<MovieService>(),
      )..fetchTopRated(),
      child: TopRatedMovieView(
        movieController: movieController,
        movieService: movieService,
      ),
    );
  }
}

class TopRatedMovieView extends StatelessWidget {
  const TopRatedMovieView(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<TopRatedCubit>().state;
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
              children: [
                Column(
                  children: const [
                    Text(
                      "No More Top Rated Movies",
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
