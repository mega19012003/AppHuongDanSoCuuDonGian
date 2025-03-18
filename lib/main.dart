import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Cần thiết cho kIsWeb
import 'package:medical_project/admin/screens/dashboard/main.dart';
import 'package:medical_project/user/widget/dashboard.dart';

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
  runApp(MyApp());
}
/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'post Detail Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dữ liệu mẫu
    post samplePost = post(
      id: 1,
      title: 'Hướng dẫn sơ cứu vết thương',
      content: 'Đây là nội dung chi tiết của bài viết về sơ cứu vết thương.',
      datePosted: '18/12/2024',
      isEdited: false,
      images: [
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
      ],
      youtubeLink: 'https://www.youtube.com/watch?v=example',
      comments: [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Chuyển sang màn hình PostDetailScreen và truyền dữ liệu post
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailScreen(post: samplePost),
              ),
            );
          },
          child: const Text('Xem chi tiết bài viết'),
        ),
      ),
    );
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ứng dụng Sơ Cứu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb ? AdminDashboard() : CusDashboard(), // Phân nhánh dựa trên nền tảng
    );
  }
}

