import 'package:flutter/material.dart';
import 'package:myapp/widgets/exercice_list.dart';
import '../widgets/side_menu.dart';
import '../widgets/dashboard_widget.dart';
import '../widgets/dashboard_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(flex: 2, child: SizedBox(child: SideMenu())),
            Expanded(
              flex: 7, 
              child: Column(
                children: [
                  Expanded(flex: 2, child:DashboardWidget()),
                  //flex 10 sprawia że lista pokazuje się na górze
                  Expanded(flex: 10, child: ExerciceList())
                ],
              )
              ),
            
            //Expanded(flex: 3, child: Container(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
