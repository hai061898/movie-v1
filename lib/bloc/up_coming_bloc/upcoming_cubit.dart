import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'upcoming_state.dart';

class UpComingCubit extends Cubit<UpComingState> {
  UpComingCubit({required this.movieService})
      : super(const UpComingState.loading());

  final MovieService movieService;

  Future<void> fetchUpComing() async {
    try {
      final movieResponse = await movieService.getUpcomingMovies();
      emit(UpComingState.success(movieResponse.movies));
    } on Exception {
      emit(const UpComingState.failure());
    }
  }
}