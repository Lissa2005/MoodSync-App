import 'package:flutter/material.dart';
//import './mood_input_Screen.dart';
//import './Interactive_platform.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MoodSync')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          //_navButton(context, 'Enter Mood', const MoodInputScreen()),
          //_navButton(context, 'Activities', const InteractivePlatform()),
        ],
      ),
    );
  }

 // Widget _navButton(BuildContext context, String text, Widget screen) {
   // return Padding(
     // padding: const EdgeInsets.only(bottom: 10),
      //child: ElevatedButton(
        //onPressed: () {
          //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (_) => screen),
          //);
        //},
        //child: Text(text),
      //),
    //);
  //}
}