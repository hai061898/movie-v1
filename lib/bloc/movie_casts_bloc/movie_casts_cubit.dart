import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/cast_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'movie_casts_state.dart';

class MovieCastsCubit extends Cubit<MovieCastsState> {
  MovieCastsCubit({required this.movieService})
      : super(const MovieCastsState.loading());

  final MovieService movieService;

  Future<void> fetchCasts(int movieId) async {
    try {
      final movieResponse = await movieService.getCasts(movieId);
      emit(MovieCastsState.success(movieResponse.casts));
    } on Exception {
      emit(const MovieCastsState.failure());
    }
  }
}