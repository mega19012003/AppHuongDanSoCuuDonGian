import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  User? currentUser;
  late TextEditingController _fullNameController;
  late TextEditingController _ageController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _ageController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _loadUserData();
  }

  // Tải thông tin người dùng từ Firebase
  Future<void> _loadUserData() async {
    try {
      // Lấy người dùng hiện tại từ Firebase Authentication
      currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Lấy thông tin người dùng từ Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid)
            .get();

        if (userDoc.exists) {
          var userData = userDoc.data() as Map<String, dynamic>;

          // Lấy thông tin từ Firestore và gán vào các controller
          _fullNameController.text = userData['fullName'] ?? '';
          _ageController.text = userData['age'].toString() ?? '';
          _phoneNumberController.text = userData['phoneNumber'] ?? '';
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  // Cập nhật thông tin người dùng
  Future<void> _updateUserInfo() async {
    if (currentUser != null) {
      try {
        // Lấy thông tin cập nhật từ các controller
        String updatedFullName = _fullNameController.text;
        int updatedAge = int.parse(_ageController.text);
        String updatedPhoneNumber = _phoneNumberController.text;

        // Cập nhật dữ liệu vào Firestore
        await FirebaseFirestore.instance.collection('users').doc(currentUser?.uid).update({
          'fullName': updatedFullName,
          'age': updatedAge,
          'phoneNumber': updatedPhoneNumber,
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thông tin đã được cập nhật')));
      } catch (e) {
        print("Error updating user data: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cập nhật thất bại')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin người dùng'),
      ),
      body: currentUser == null
          ? Center(child: CircularProgressIndicator()) // Nếu chưa lấy được thông tin người dùng, hiển thị loading
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${currentUser?.email}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Họ và tên'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Tuổi'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Số điện thoại'),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _updateUserInfo,
                child: Text('Cập nhật thông tin'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
