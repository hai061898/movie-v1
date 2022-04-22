import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/bloc/controllers/movie_controller.dart';
import 'package:movie/bloc/widgets/bottom_bavbar.dart';
import 'package:movie/data/services/movie_service.dart';
import 'package:movie/ui/screens/home/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {Key? key, required this.movieController, required this.movieService})
      : super(key: key);

  final MovieController movieController;
  final MovieService movieService;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BottomNavBarBloc _bottomNavBarBloc = BottomNavBarBloc();
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = widget.movieController.themeMode == ThemeMode.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
          body: StreamBuilder<NavBarItem>(
            stream: _bottomNavBarBloc.itemStream,
            initialData: _bottomNavBarBloc.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              switch (snapshot.data) {
                case NavBarItem.home:
                  return HomeScreen(
                      movieService: widget.movieService,
                      movieController: widget.movieController);
                case NavBarItem.genres:
                  return Container();
                case NavBarItem.search:
                  return Container();
                case NavBarItem.profile:
                  return Container();
                default:
                  return Container();
              }
            },
          ),
          bottomNavigationBar: StreamBuilder(
            stream: _bottomNavBarBloc.itemStream,
            initialData: _bottomNavBarBloc.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 0.5, color: Colors.grey.withOpacity(0.4)))),
                child: BottomNavigationBar(
                  elevation: 0.9,
                  iconSize: 21,
                  unselectedFontSize: 10.0,
                  selectedFontSize: 10.0,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: snapshot.data!.index,
                  onTap: _bottomNavBarBloc.pickItem,
                  items: [
                    BottomNavigationBarItem(
                      label: "Home",
                      icon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/home.svg",
                          color: Colors.grey.shade700,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/home-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Genres",
                      icon: SvgPicture.asset(
                        "assets/icons/layers.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/layers-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Search",
                      icon: SvgPicture.asset(
                        "assets/icons/search.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/search-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Profile",
                      icon: SvgPicture.asset(
                        "assets/icons/profile.svg",
                        color: Colors.grey.shade700,
                        height: 25.0,
                        width: 25.0,
                      ),
                      activeIcon: SizedBox(
                        child: SvgPicture.asset(
                          "assets/icons/profile-active.svg",
                          color: Colors.white,
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
