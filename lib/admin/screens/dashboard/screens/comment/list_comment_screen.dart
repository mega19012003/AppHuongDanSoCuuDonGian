import 'package:flutter/material.dart';
import 'package:medical_project/admin/screens/dashboard/screens/comment/components/header.dart';

class CommentListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách bài viết'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            // Nút thêm bài viết
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              /*children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Thêm bài viết logic
                  },
                  icon: Icon(Icons.add),
                  label: Text('Thêm bài viết'),
                ),
              ],*/
            ),
            SizedBox(height: 16.0),
            // Bảng dữ liệu
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth; // Lấy chiều rộng màn hình
                  double columnWidth = screenWidth / 5; // Chia đều không gian cho 4 cột

                  return DataTable(
                    columnSpacing: columnWidth * 0.1, // Tùy chỉnh khoảng cách giữa các cột
                    columns: [
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('ID'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Tên người bình luận'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Bài viết'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Ngày đăng'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Trạng thái'))),
                    ],
                    rows: List<DataRow>.generate(
                      10,
                          (index) => DataRow(
                        cells: [
                          DataCell(SizedBox(width: columnWidth, child: Text(index.toString()))),
                          DataCell(SizedBox(width: columnWidth, child: Text('Tên người dùng $index'))),
                          DataCell(SizedBox(width: columnWidth, child: Text('28/02/1995'))),
                          DataCell(SizedBox(width: columnWidth, child: Text('Giới tính $index'))),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Xóa logic
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                                /*IconButton(
                                  onPressed: () {
                                    // Sửa logic
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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

void main() {
  runApp(MaterialApp(
    home: CommentListScreen(),
  ));
}