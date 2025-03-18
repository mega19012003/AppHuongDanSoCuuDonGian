import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/models/articleContent.dart';

class ArticleRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Hàm thêm bài viết và các bước vào Firestore
  Future<void> addArticle(Article article) async {
    try {
      // Lưu bài viết vào Firestore
      await _firestore.collection('articles').add(article.toMap());
      print("Bài viết đã được thêm thành công.");
    } catch (e) {
      print("Lỗi khi thêm bài viết: $e");
    }
  }

  // Hàm lấy tất cả bài viết từ Firestore
  Future<List<Article>> getAllArticles() async {
    try {
      var querySnapshot = await _firestore.collection('articles').get();
      return querySnapshot.docs
          .map((doc) => Article.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Lỗi khi lấy dữ liệu bài viết: $e");
      return [];
    }
  }

  // Hàm cập nhật bài viết
  Future<void> updateArticle(String articleId, String newTitle, List<StepContent> updatedStepContents) async {
    try {
      await _firestore.collection('articles').doc(articleId).update({
        'title': newTitle,
        'stepContent': updatedStepContents.map((step) => step.toMap()).toList(), // Cập nhật các bước
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Lỗi khi cập nhật bài viết: $e");
    }
  }


  // Hàm xóa bài viết khỏi Firestore
  Future<void> deleteArticle(String id) async {
    try {
      await _firestore.collection('articles').doc(id).delete();
      print("Bài viết đã được xoá thành công.");
    } catch (e) {
      print("Lỗi khi xóa bài viết: $e");
    }
  }
}