import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
//trang để test
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test  screen"),
      ),
      body: Center(
        child: Text(
          "demo  screen!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
