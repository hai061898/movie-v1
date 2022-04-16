
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

import 'package:stream_transform/stream_transform.dart';

part 'all_movies_event.dart';
part 'all_movies_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({required this.movieService}) : super(const MovieState()) {
    on<MovieFetched>(
      _onMovieFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final MovieService movieService;
  int totalData = 0;

  Future<void> _onMovieFetched(
    MovieFetched event,
    Emitter<MovieState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await _fetchMovies(1);
        return emit(state.copyWith(
            status: MovieStatus.success,
            movies: movies,
            hasReachedMax: false,
            page: 1));
      }
      final movies = await _fetchMovies(state.page + 1);
      totalData == movies.length
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MovieStatus.success,
                movies: List.of(state.movies)..addAll(movies),
                page: state.page + 1,
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MovieStatus.failure));
    }
  }

  Future<List<Movie>> _fetchMovies(int page) async {
    MovieResponse movieResponse = await movieService.getMovies(page);

    if (!movieResponse.hasError) {
      totalData = movieResponse.totalResults;
      return movieResponse.movies;
    }
    throw Exception('error fetching movies');
  }
}