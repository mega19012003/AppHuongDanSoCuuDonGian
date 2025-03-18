import 'package:flutter/material.dart';
import 'package:medical_project/admin/screens/dashboard/controllers/menu_app_controller.dart';
import 'package:medical_project/admin/screens/dashboard/responsive.dart';
import 'package:medical_project/admin/screens/dashboard/screens/comment/list_comment_screen.dart';
import 'package:medical_project/admin/screens/dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:medical_project/admin/screens/dashboard/screens/main/components/side_menu.dart';
import 'package:medical_project/admin/screens/dashboard/screens/post/list_article_screen.dart';
import 'package:medical_project/admin/screens/dashboard/screens/user/list_user_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Chỉ số màn hình đang được chọn

  void _onMenuItemTap(int index) {
    setState(() {
      _selectedIndex = index; // Cập nhật chỉ số khi chọn mục
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(onMenuItemTap: _onMenuItemTap), // Truyền callback
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(onMenuItemTap: _onMenuItemTap),
              ),
            Expanded(
              flex: 5,
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  DashboardScreen(), // Màn hình mặc định
                  ArticleListPage(),
                  UserListScreen(),
                  //CommentListScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
import 'package:medical_project/admin/screens/dashboard/controllers/menu_app_controller.dart';
import 'package:medical_project/admin/screens/dashboard/responsive.dart';
import 'package:medical_project/admin/screens/dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}*/
