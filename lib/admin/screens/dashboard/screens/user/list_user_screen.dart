import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_project/admin/screens/dashboard/screens/comment/components/header.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách người dùng'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(), // Nếu có
            SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Không có người dùng nào.'));
                  }

                  var users = snapshot.data!.docs;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = constraints.maxWidth;
                      double columnWidth = screenWidth / 5; // Chia đều không gian cho 5 cột

                      return DataTable(
                        columnSpacing: 0, // Loại bỏ khoảng cách mặc định giữa các cột
                        columns: [
                          DataColumn(label: Container(width: columnWidth, child: Text('ID'))),
                          DataColumn(label: Container(width: columnWidth, child: Text('Tên người dùng'))),
                          DataColumn(label: Container(width: columnWidth, child: Text('Ngày sinh'))),
                          DataColumn(label: Container(width: columnWidth, child: Text('Giới tính'))),
                          DataColumn(label: Container(width: columnWidth, child: Text('Trạng thái'))),
                        ],
                        rows: users.map<DataRow>((userDoc) {
                          var userData = userDoc.data() as Map<String, dynamic>;
                          String userId = userDoc.id;
                          String fullName = userData['fullName'] ?? 'Chưa có tên';
                          String birthDate = userData['birthDate'] ?? 'Chưa có';
                          String gender = userData['gender'] ?? 'Chưa có';
                          String status = userData['status'] ?? 'Chưa có';

                          return DataRow(
                            cells: [
                              DataCell(Container(width: columnWidth, child: Text(userId))),
                              DataCell(Container(width: columnWidth, child: Text(fullName))),
                              DataCell(Container(width: columnWidth, child: Text(birthDate))),
                              DataCell(Container(width: columnWidth, child: Text(gender))),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Xóa người dùng logic
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userId)
                                            .delete();
                                      },
                                      icon: Icon(Icons.delete, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: UserListScreen(),
  ));
}
