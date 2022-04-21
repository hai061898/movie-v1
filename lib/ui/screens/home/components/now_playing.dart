import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/bloc/now_playing_bloc/now_playing_cubit.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/widgets/movie_list_loading.dart';
import 'package:movie/ui/widgets/movies_list_horizontal.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);

  final MovieController movieController;
  final MovieService movieService;

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.movieService,
      child: NowPlayingList(
        movieController: widget.movieController,
        movieService: widget.movieService,
      ),
    );
  }
}

class NowPlayingList extends StatelessWidget {
  const NowPlayingList(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NowPlayingCubit(
        movieService: context.read<MovieService>(),
      )..fetchList(),
      child: NowPlayingView(
        movieController: movieController,
        movieService: movieService,
      ),
    );
  }
}

class NowPlayingView extends StatelessWidget {
  const NowPlayingView(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);
  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<NowPlayingCubit>().state;
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
