import 'package:flutter/material.dart';
import 'package:movie_app/network/loginDataBase.dart';
import 'package:movie_app/welcomeScreen/welcome.dart';

import 'Screens/favorite.dart';
import 'Screens/home.dart';
import 'Screens/profile.dart';
import 'constant.dart';
import 'network/favoriteDataBase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FavDataProvider.instance.open();
  DbHelper.instance.initDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
    );
  }
}

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({
    super.key,
  });

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  @override
  List<Map<String, dynamic>> _pages = [
    {'page': MyHomePage(), 'title': 'Home'},
    {'page': FavoritePage(), 'title': 'Favourite'},
    {'page': ProfilePage(), 'title': 'Profile'}
  ];
  int _selectedPageIndex = 0;
  Index(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Constants.secondryColor,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        onTap: Index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
