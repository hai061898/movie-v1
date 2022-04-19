import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'movie_list_state.dart';

class MovieListCubit extends Cubit<MovieListState> {
  MovieListCubit({required this.movieService})
      : super(const MovieListState.loading());

  final MovieService movieService;

  Future<void> fetchList() async {
    try {
      final movieResponse = await movieService.getMovies(1);
      emit(MovieListState.success(movieResponse.movies));
    } on Exception {
      emit(const MovieListState.failure());
    }
  }
}