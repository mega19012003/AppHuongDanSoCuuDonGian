import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailArticleScreen extends StatelessWidget {
  final String articleId; // ID bài viết được truyền vào

  const DetailArticleScreen({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi Tiết Bài Viết'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('articles') // Bộ sưu tập Firestore
            .doc(articleId) // Lấy tài liệu với ID bài viết
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Có lỗi xảy ra khi tải bài viết.'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Bài viết không tồn tại.'));
          }

          // Trích xuất dữ liệu bài viết
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final title = data['title'] ?? 'Không có tiêu đề';
          final datePosted = (data['datePosted'] as Timestamp).toDate();
          final contentList = List<Map<String, dynamic>>.from(data['content'] ?? []);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ngày đăng: ${datePosted.day}/${datePosted.month}/${datePosted.year}',
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const Divider(height: 32, thickness: 2),
                const Text(
                  'Nội dung bài viết:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    itemCount: contentList.length,
                    itemBuilder: (context, index) {
                      final step = contentList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                step['imageUrl'] ?? '',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.broken_image, size: 100);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                step['content'] ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
