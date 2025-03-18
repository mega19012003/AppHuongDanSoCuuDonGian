import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/models/articleContent.dart';

class AddArticleScreen extends StatefulWidget {
  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController stepContentController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  List<StepContent> stepContents = []; // Danh sách StepContent tạm thời

  void addStepContent() {
    if (stepContentController.text.isNotEmpty && imageUrlController.text.isNotEmpty) {
      setState(() {
        stepContents.add(StepContent(
          content: stepContentController.text,
          imageUrl: imageUrlController.text,
        ));
      });
      stepContentController.clear();
      imageUrlController.clear();
    }
  }

  void deleteStepContent(int index) {
    setState(() {
      stepContents.removeAt(index);
    });
  }

  void editStepContent(int index) {
    // Hiển thị hộp thoại chỉnh sửa
    final step = stepContents[index];
    stepContentController.text = step.content;
    imageUrlController.text = step.imageUrl;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chỉnh sửa StepContent'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: stepContentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                stepContents[index] = StepContent(
                  content: stepContentController.text,
                  imageUrl: imageUrlController.text,
                );
              });
              stepContentController.clear();
              imageUrlController.clear();
              Navigator.of(context).pop();
            },
            child: Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void saveArticle() {
    final newArticle = Article(
      title: titleController.text,
      datePosted: Timestamp.now(),
      content: stepContents,
      id: '', // Có thể để trống hoặc bỏ qua ID vì Firestore tự sinh ID
    );

    // Lưu bài viết vào Firestore
    FirebaseFirestore.instance.collection('articles').add({
      'title': newArticle.title,
      'datePosted': newArticle.datePosted,
      'content': newArticle.content.map((step) {
        return {
          'content': step.content,
          'imageUrl': step.imageUrl, // Lưu URL ảnh vào Firestore
        };
      }).toList(),
    }).then((docRef) {
      // Reset trạng thái sau khi lưu thành công
      titleController.clear();
      setState(() {
        stepContents.clear();
      });

      // Thông báo cho người dùng
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bài viết đã được thêm.')),
      );
    }).catchError((error) {
      // Xử lý lỗi khi lưu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $error')),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Bài Viết'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề bài viết'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: stepContentController,
              decoration: InputDecoration(labelText: 'Nội dung bước'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: 'URL ảnh'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addStepContent,
              child: Text('Thêm StepContent'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: stepContents.length,
                itemBuilder: (context, index) {
                  final step = stepContents[index];
                  return ListTile(
                    title: Text(step.content),
                    subtitle: Text(step.imageUrl),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => editStepContent(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteStepContent(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveArticle,
              child: Text('Lưu bài viết'),
            ),
          ],
        ),
      ),
    );
  }
}
