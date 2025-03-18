import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  int id; // ID duy nhất cho bình luận
  String userId; // ID của người bình luận
  String username; // Tên người bình luận
  String content; // Nội dung bình luận
  Timestamp commentDate; // Ngày bình luận

  Comment({
    required this.id,
    required this.userId,
    required this.username,
    required this.content,
    required this.commentDate,
  });

  // Phương thức chuyển đổi từ Map (Firebase) thành đối tượng Comment
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      content: map['content'] ?? '',
      commentDate:  map['content'] ?? '',
    );
  }

  // Phương thức chuyển đổi đối tượng Comment thành Map (để lưu vào Firebase)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'content': content,
      'commentDate': commentDate,
    };
  }
}
