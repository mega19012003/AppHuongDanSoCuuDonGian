import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/models/articleContent.dart';

class ArticleSearch {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Hàm tìm kiếm bài viết theo tiêu đề hoặc nội dung
  Future<List<Article>> searchArticles(String searchTerm) async {
    try {
      // Truy vấn bài viết có title chứa từ khóa tìm kiếm
      QuerySnapshot querySnapshot = await _firestore
          .collection('articles')
          .where('title', isGreaterThanOrEqualTo: searchTerm)
          .where('title', isLessThanOrEqualTo: '$searchTerm\uf8ff') // Phạm vi tìm kiếm
          .get();

      List<Article> articles = querySnapshot.docs.map((doc) {
        // Chuyển đổi từ Firestore document sang đối tượng Article
        return Article(
          id: doc.id,
          title: doc['title'],
          datePosted: doc['datePosted'],
          content: List<StepContent>.from(doc['content'].map((step) {
            return StepContent(
              content: step['content'],
              imageUrl: step['imageUrl'],
            );
          })),
        );
      }).toList();

      return articles;
    } catch (e) {
      print('Error searching articles: $e');
      return [];
    }
  }
}