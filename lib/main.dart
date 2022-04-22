import 'package:flutter/material.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/screens/main/main_page.dart';
import 'package:movie/ui/themes/custom_theme.dart';

Future<void> main() async {
  final movieService = MovieService();
  final movieController = MovieController(ThemeService());
  await movieController.loadSettings();
  runApp(App(
    movieController: movieController,
    movieService: movieService,
  ));
}

class App extends StatelessWidget {
  const App(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);

  final MovieController movieController;
  final MovieService movieService;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: movieController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          restorationScopeId: 'app',
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          themeMode: movieController.themeMode,
          home: MainScreen(
            movieController: movieController,
            movieService: movieService,
          ),
        );
      },
    );
  }
}
