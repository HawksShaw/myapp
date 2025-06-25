import 'package:flutter/material.dart';
import '../widgets/side_menu.dart';
import 'homescreen_content.dart';
// import '../widgets/profile_screen_content.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hi, I'm the Placeholder"), centerTitle: true),
      drawer: SideMenu(
        selectedIndex: _selectedIndex,
        checkItem: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return HomeScreenContent();
      // case 1:
      //   return ProfilePageContent();
      default:
        return HomeScreenContent();
    }
  }
}