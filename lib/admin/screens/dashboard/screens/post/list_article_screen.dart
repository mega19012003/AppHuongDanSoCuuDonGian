import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_project/admin/repositories/article_repository.dart';
import 'package:medical_project/admin/screens/dashboard/screens/post/add_article_screen.dart';
import 'package:medical_project/admin/screens/dashboard/screens/post/detail_article_screen.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/models/articleContent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Article Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArticleListPage(),
    );
  }
}

class ArticleListPage extends StatefulWidget {
  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final ArticleRepository _articleRepo = ArticleRepository();
  late Future<List<Article>> _articleList;

  @override
  void initState() {
    super.initState();
    _articleList = _articleRepo.getAllArticles();
  }

  // Hàm hiển thị thời gian dưới định dạng dd/MM/yyyy
  String _formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year}";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Sách Bài Viết'),
      ),
      body: Column(
        children: [
          // Nút chuyển sang trang thêm bài viết
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Thêm Bài Viết Mới'),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddArticleScreen()),
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Article>>(
              future: _articleList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Có lỗi xảy ra.'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Không có bài viết nào.'));
                }
                final articles = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: MediaQuery.of(context).size.width * 0.15,
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Tiêu Đề')),
                      DataColumn(label: Text('Ngày Đăng')),
                      DataColumn(label: Text('Chức Năng')),
                    ],
                    rows: articles.map((article) {
                      return DataRow(cells: [
                        DataCell(Text(article.id)),
                        DataCell(Text(article.title ?? 'Chưa có tiêu đề')),
                        DataCell(Text(_formatDate(article.datePosted))),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.visibility),
                              onPressed: () {
                                // Code xem bài viết
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailArticleScreen(articleId: article.id),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Hiển thị hộp thoại sửa bài viết
                                _showEditDialog(article);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Xác nhận và xóa bài viết
                                _deleteArticle(article.id);
                              },
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  // Hàm gọi Repository để xóa bài viết
  void _deleteArticle(String id) async {
    await _articleRepo.deleteArticle(id);
    setState(() {
      _articleList = _articleRepo.getAllArticles(); // Cập nhật lại danh sách
    });
  }

  // Hàm hiển thị hộp thoại để sửa bài viết và từng StepContent
  void _showEditDialog(Article article) {
    final TextEditingController titleController = TextEditingController(text: article.title);

    // Tạo controller cho các StepContent (giả sử bài viết có nhiều bước)
    List<TextEditingController> stepContentControllers = [];
    List<TextEditingController> imageUrlControllers = [];
    article.content.forEach((step) {
      stepContentControllers.add(TextEditingController(text: step.content));  // Khởi tạo controller cho từng bước
      imageUrlControllers.add(TextEditingController(text: step.imageUrl));  // Khởi tạo controller cho URL hình ảnh
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chỉnh sửa bài viết'),
        content: SingleChildScrollView( // Dùng SingleChildScrollView để tránh tràn khi có nhiều bước
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // TextField cho tiêu đề bài viết
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Tiêu đề'),
              ),
              // TextField cho từng bước nội dung và URL ảnh
              ...article.content.asMap().entries.map((entry) {
                int index = entry.key;
                StepContent step = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: stepContentControllers[index],  // Sử dụng controller tương ứng với bước
                        decoration: InputDecoration(labelText: 'Bước ${index + 1}: ${step.content}'),
                      ),
                      TextField(
                        controller: imageUrlControllers[index],  // Controller cho URL ảnh
                        decoration: InputDecoration(labelText: 'URL ảnh cho bước ${index + 1}'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng hộp thoại nếu người dùng bấm "Hủy"
            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              final updatedTitle = titleController.text;

              if (updatedTitle.isNotEmpty) {
                // Cập nhật bài viết với tiêu đề mới và các bước sửa đổi
                List<StepContent> updatedStepContents = [];
                for (int i = 0; i < article.content.length; i++) {
                  updatedStepContents.add(StepContent(
                    content: stepContentControllers[i].text,  // Sửa nội dung
                    imageUrl: imageUrlControllers[i].text.isNotEmpty
                        ? imageUrlControllers[i].text  // Cập nhật URL ảnh nếu có
                        : article.content[i].imageUrl,  // Nếu không có, giữ nguyên URL ảnh cũ
                  ));
                }

                // Cập nhật bài viết vào Firestore
                await _articleRepo.updateArticle(article.id, updatedTitle, updatedStepContents);

                // Đóng hộp thoại
                Navigator.of(context).pop();

                // Cập nhật lại danh sách bài viết
                setState(() {
                  _articleList = _articleRepo.getAllArticles();
                });

                // Hiển thị thông báo thành công
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bài viết đã được cập nhật.')),
                );
              } else {
                // Nếu tiêu đề trống, yêu cầu người dùng nhập tiêu đề
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Vui lòng nhập tiêu đề!')),
                );
              }
            },
            child: Text('Lưu'),
          ),
        ],
      ),
    );
  }
}


/*
class PostListScreen extends StatelessWidget {
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
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Thêm bài viết logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddArticleScreen()), // Chuyển hướng sang màn hình khác
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text('Thêm bài viết'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Bảng dữ liệu
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = constraints.maxWidth; // Lấy chiều rộng màn hình
                  double columnWidth = screenWidth / 4; // Chia đều không gian cho 4 cột

                  return DataTable(
                    columnSpacing: columnWidth * 0.1, // Tùy chỉnh khoảng cách giữa các cột
                    columns: [
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('ID'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Tiêu đề'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Ngày đăng'))),
                      DataColumn(label: SizedBox(width: columnWidth, child: Text('Trạng thái'))),
                    ],
                    rows: List<DataRow>.generate(
                      10,
                          (index) => DataRow(
                        cells: [
                          DataCell(SizedBox(width: columnWidth, child: Text(index.toString()))),
                          DataCell(SizedBox(width: columnWidth, child: Text('Tiêu đề $index'))),
                          DataCell(SizedBox(width: columnWidth, child: Text('01/01/2024'))),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Xóa logic
                                  },
                                  icon: Icon(Icons.delete, color: Colors.red),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Sửa logic
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                ),
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
    home: PostListScreen(),
  ));
}*/
