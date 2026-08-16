import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/welcomeScreen/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'Guest';
      userEmail = prefs.getString('email') ?? '';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const WelcomePage()),
      (route) => false,
    );
  }

  Widget _settingsRow({
    required IconData icon,
    required String title,
    String? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Constants.secondryColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                color: Color(0xffE73c37),
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    ),
                    child: SizedBox(
                      height: 200,
                      width: screenWidth,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvnDyLGaS2rDeKoMVQJDtoefxzEG8DKt7MYLoqkYaGl3ZYfc6VOiNzFENZ5SeuoJxa2k4&usqp=CAU',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Constants.secondryColor.withValues(alpha: 0.4),
                            ),
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 9.0),
                            child: Container(
                              color: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    heightFactor: 1.7,
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white24,
                      backgroundImage: const NetworkImage(
                        'https://i.pinimg.com/474x/5d/05/96/5d0596ab050e94e1fe07687e107f61c9.jpg',
                      ),
                      onBackgroundImageError: (_, __) {},
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      userName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      userEmail,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          _settingsRow(
                            icon: Icons.notifications,
                            title: 'Notification',
                            trailing: 'on',
                          ),
                          _settingsRow(
                            icon: Icons.language,
                            title: 'Language',
                            trailing: 'English',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          _settingsRow(
                            icon: Icons.security_rounded,
                            title: 'Security',
                          ),
                          _settingsRow(
                            icon: Icons.color_lens,
                            title: 'Theme',
                            trailing: 'Light Mode',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          _settingsRow(
                            icon: Icons.help,
                            title: 'Help & Support',
                          ),
                          _settingsRow(
                            icon: Icons.mail_sharp,
                            title: 'Contact Us',
                          ),
                          _settingsRow(
                            icon: Icons.lock,
                            title: 'Privacy Policy',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.secondryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _logout,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
