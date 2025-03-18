import 'package:flutter/material.dart';
import 'package:medical_project/user/screens/serviceScreen.dart';
import 'package:medical_project/user/screens/ToolScreen.dart';
import '../screens/homeScreen.dart';

class CusDashboard extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<CusDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    ListArticlePage(),
    ToolPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Nội dung màn hình thay đổi theo chỉ số hiện tại
      body: _screens[_currentIndex],

      // Thanh điều hướng nằm ở dưới
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cập nhật chỉ số khi nhấn
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Bài viết',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}
