import 'package:flutter/material.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/screens/home/components/now_playing.dart';
import 'package:movie/ui/screens/home/components/popular_movies.dart';
import 'package:movie/ui/screens/home/components/top_rated_movies.dart';
import 'package:movie/ui/screens/home/components/up_coming.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);

  final MovieController movieController;
  final MovieService movieService;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          UpComing(
              movieService: widget.movieService,
              movieController: widget.movieController),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Now Playing"),
          ),
          NowPlaying(
              movieService: widget.movieService,
              movieController: widget.movieController),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("Popular Movies"),
          ),
          PopularMovies(
              movieService: widget.movieService,
              movieController: widget.movieController),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text("AllTime Top Rated Movies"),
          ),
          TopRatedMovies(
              movieService: widget.movieService,
              movieController: widget.movieController)
        ],
      ),
    );
  }
}
