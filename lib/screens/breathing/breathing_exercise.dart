import 'package:eit_app/screens/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';

class BreathingExercise extends StatelessWidget {
  static const routeName = '/breathe';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xfffbfbfb),
      body: Center(
        child: Image(
          image: AssetImage('lib/assets/images/breathing.gif'),
          
        ),
      ),
      bottomNavigationBar: bottomNavBar(context),
    );
  }

}