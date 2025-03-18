import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medical_project/admin/screens/dashboard/screens/main/main_screen.dart';
import 'package:medical_project/user/services/userService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb) { //cấu hình Firebase nếu là web
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyCwkNMmIDstul2cYNqXS3uQGxQ7yGZPEFI",
        authDomain: "medical-sample-8ee1b.firebaseapp.com",
        projectId: "medical-sample-8ee1b",
        storageBucket: "medical-sample-8ee1b.firebasestorage.app",
        messagingSenderId: "416364664156",
        appId: "1:416364664156:web:83976844bca562815e1d99"));
  }
  else {
    await Firebase.initializeApp();
  }
  runApp(AdminLoginPage());
}

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserService _userService = UserService();

  void _loginAdmin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Gọi hàm loginWithEmail từ UserService
      final role = await _userService.loginWithEmail(email, password);

      if (role == 'admin') {
        // Chuyển hướng sang giao diện admin
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      } else {
        // Hiển thị thông báo nếu không phải admin
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bạn không có quyền truy cập admin.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loginAdmin,
                child: Text('Login as Admin'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
