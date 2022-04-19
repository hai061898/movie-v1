import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit({required this.movieService})
      : super(const SimilarMoviesState.loading());

  final MovieService movieService;

  Future<void> fetchList(int movieId) async {
    try {
      final movieResponse = await movieService.getSimilarMovies(movieId);
      emit(SimilarMoviesState.success(movieResponse.movies));
    } on Exception {
      emit(const SimilarMoviesState.failure());
    }
  }
}