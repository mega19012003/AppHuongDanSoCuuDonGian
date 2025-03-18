/*class post {
  final String id; // ID của bài viết
  final String title; // Tiêu đề bài viết
  final String content; // Nội dung bài viết
  final String imageUrl; // URL hình ảnh minh họa
  final double rating; // Đánh giá trung bình
  final List<Comment> comments; // Danh sách bình luận

  post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.rating,
    required this.comments,
  });

  // Hàm từ JSON map (dùng Firebase hoặc REST API)
  factory post.fromJson(Map<String, dynamic> json) {
    return post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      comments: (json['comments'] as List)
          .map((comment) => Comment.fromJson(comment))
          .toList(),
    );
  }

  // Hàm để chuyển sang JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'rating': rating,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}*/
