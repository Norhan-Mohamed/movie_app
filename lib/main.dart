import 'package:flutter/material.dart';
import 'package:movie_app/network/loginDataBase.dart';
import 'package:movie_app/welcomeScreen/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/favorite.dart';
import 'Screens/home.dart';
import 'Screens/profile.dart';
import 'constant.dart';
import 'network/favoriteDataBase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavDataProvider.instance.open();
  await DbHelper.instance.initDb();

  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

  runApp(MyApp(startLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool startLoggedIn;

  const MyApp({super.key, this.startLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startLoggedIn ? const NavigationBarPage() : const WelcomePage(),
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
  int _selectedPageIndex = 0;
  int _favoriteKey = 0;

  void Index(int index) {
    setState(() {
      _selectedPageIndex = index;
      if (index == 1) {
        _favoriteKey++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const MyHomePage(),
      FavoritePage(key: ValueKey(_favoriteKey)),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        backgroundColor: Constants.secondryColor,
        selectedItemColor: Constants.primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        onTap: Index,
        type: BottomNavigationBarType.fixed,
        items: const [
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
