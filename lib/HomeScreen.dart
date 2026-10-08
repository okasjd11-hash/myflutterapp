
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App-bar"),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(


          children: [
            SizedBox(height: 30,),
            Text("Today's news :", style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
