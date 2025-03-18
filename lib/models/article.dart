import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_project/models/comments.dart';
import 'package:medical_project/models/articleContent.dart';

class Article {
  String id;
  String title;
  Timestamp datePosted;
  // Danh sách ảnh liên quan đến bài viết
  final List<StepContent> content; // Danh sách các bước hoặc phần nội dung chi tiết
  //String? youtubeLink;
  // Danh sách bình luận của bài viết
  //List<Comment> comments;

  Article({
    required this.id,
    required this.title,
    required this.datePosted,
    required this.content,
    //required this.youtubeLink,
    //required this.comments,
  });

  // Sao chép Post với ID mới
  Article copyWith({required String id}) {
    return Article(
      id: id,
      title: title,
      datePosted: datePosted,
      //isEdited: isEdited,
      content: content,
      // youtubeLink: youtubeLink,
      //comments: comments,
    );
  }

  // Hàm chuyển đổi từ Map (Firestore) sang Article
  factory Article.fromMap(Map<String, dynamic> data, String documentId) {
    var contentList = (data['content'] as List)
        .map((step) => StepContent.fromMap(step))
        .toList();

    return Article(
      id: documentId,
      title: data['title'],
      datePosted: data['datePosted'],
      content: contentList,
    );
  }

  // Hàm chuyển đổi từ Article sang Map để lưu vào Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'datePosted': datePosted,
      'content': content.map((e) => e.toMap()).toList(),
    };
  }

}
