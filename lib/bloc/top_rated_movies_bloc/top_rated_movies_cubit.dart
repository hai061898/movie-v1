import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'top_rated_movies_state.dart';
class TopRatedCubit extends Cubit<TopRatedState> {
  TopRatedCubit({required this.movieService})
      : super(const TopRatedState.loading());

  final MovieService movieService;

  Future<void> fetchTopRated() async {
    try {
      final movieResponse = await movieService.getTopRatedMovies();
      emit(TopRatedState.success(movieResponse.movies));
    } on Exception {
      emit(const TopRatedState.failure());
    }
  }
}