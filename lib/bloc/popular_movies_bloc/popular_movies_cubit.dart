import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'popular_movies_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  PopularMovieCubit({required this.movieService})
      : super(const PopularMovieState.loading());

  final MovieService movieService;

  Future<void> fetchList() async {
    try {
      final movieResponse = await movieService.getPopuparMovies(1);
      emit(PopularMovieState.success(movieResponse.movies));
    } on Exception {
      emit(const PopularMovieState.failure());
    }
  }
}