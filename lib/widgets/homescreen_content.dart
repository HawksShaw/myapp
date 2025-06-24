import 'package:flutter/material.dart';
import '../widgets/dashboard_widget.dart';
import '../widgets/exercise_list.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 2, child: DashboardWidget()),
            Expanded(flex: 10, child: ExerciseList()),
          ]
        ),
      ),
    );
  }
}
