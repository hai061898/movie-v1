import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_detail_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit({required this.repository})
      : super(const MovieDetailState.loading());

  final MovieService repository;

  Future<void> fetchMovie(int id) async {
    try {
      final movieResponse = await repository.getMovieDetail(id);

      emit(MovieDetailState.success(movieResponse.movieDetail));
    } on Exception {
      emit(const MovieDetailState.failure());
    }
  }
}