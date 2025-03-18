import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const double defaultPadding = 20.0;

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Text(
              'Xin chào Admin',
              style: TextStyle(
                fontSize: 30, // Chữ lớn hơn
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: defaultPadding),
            Text(
              getCurrentDateTime(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm lấy thời gian và ngày hiện tại
  String getCurrentDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(now);
  }
}

// Header widget đơn giản
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dashboard',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: DashboardScreen(),
    ),
  ));
}