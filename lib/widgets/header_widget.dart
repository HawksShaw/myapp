import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.amber),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5),
          hintText: 'Search for users, groups or ongoing events',
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
        ),
      ),
    );
  }
}
