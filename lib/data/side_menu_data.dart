import 'package:flutter/material.dart';
import '../models/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Home'),
    MenuModel(icon: Icons.person, title: 'Profile'),
    MenuModel(icon: Icons.run_circle, title: 'Activity'),
    MenuModel(icon: Icons.event, title: 'Events'),
    MenuModel(icon: Icons.history, title: 'Recent'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.logout, title: 'Logout'),
  ];
}
