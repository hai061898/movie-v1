import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/services/movie_service.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  NowPlayingCubit({required this.movieService})
      : super(const NowPlayingState.loading());

  final MovieService movieService;

  Future<void> fetchList() async {
    try {
      final movieResponse = await movieService.getNowPlaying(1);
      emit(NowPlayingState.success(movieResponse.movies));
    } on Exception {
      emit(const NowPlayingState.failure());
    }
  }
}