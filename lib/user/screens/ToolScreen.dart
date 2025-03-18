import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Thêm FirebaseAuth
import 'package:medical_project/user/screens/AppInfoScreen.dart';
import 'package:medical_project/user/screens/LoginScreen.dart';
import 'package:medical_project/user/screens/RegisterScreen.dart';
import 'package:medical_project/user/screens/UserInfoScreen.dart';

class ToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cài đặt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<User?>(
        future: Future.value(_auth.currentUser), // Kiểm tra trạng thái đăng nhập
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Hiển thị loading khi đợi
          }
          final User? user = snapshot.data;
          final bool isLoggedIn = user != null;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (!isLoggedIn) ...[
                  // Nếu chưa đăng nhập, hiển thị các nút Đăng ký và Đăng nhập
                  buildButton(context, 'Đăng ký tài khoản', onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  }),
                  buildButton(context, 'Đăng nhập tài khoản', onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }),
                ],
                if (isLoggedIn) ...[
                  // Nếu đã đăng nhập, hiển thị các nút thông tin user và Đăng xuất
                  buildButton(context, 'Xem thông tin người dùng', onPressed: () {
                    // Xử lý xem thông tin người dùng
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserInfoPage()),
                    );
                  }),
                  buildButton(context, 'Đăng xuất tài khoản', color: Colors.red, onPressed: () async {
                    await _auth.signOut(); // Đăng xuất tài khoản
                    setState(() {}); // Cập nhật giao diện
                  }),
                ],
                buildButton(context, 'Xem thông tin ứng dụng', onPressed: () {
                  // Xử lý xem thông tin ứng dụng
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppInfoPage()),
                  );
                }),
                buildButton(context, 'Thoát ứng dụng', onPressed: () {
                  SystemNavigator.pop();
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildButton(BuildContext context, String text,
      {Color color = Colors.grey, required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color, // Màu nền của nút
            foregroundColor: Colors.white, // Màu chữ của nút
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
