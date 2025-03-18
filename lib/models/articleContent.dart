import 'package:flutter/material.dart';

class StepContent {
  final String content; // Nội dung của bước/đoạn
  final String imageUrl; // URL của hình ảnh

  StepContent({
    required this.content,
    required this.imageUrl,
  });

  // Hàm chuyển đổi từ StepContent sang Map
  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'imageUrl': imageUrl,
    };
  }
  // Chuyển từ Map (JSON) sang StepContent
  factory StepContent.fromMap(Map<String, dynamic> json) {
    return StepContent(
      content: json['content'],
      imageUrl: json['imageUrl'],
    );
  }
}
/*
class StepContentController {
  final TextEditingController contentController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  // Hàm để lấy dữ liệu từ các controller
  StepContent getStepContent() {
    return StepContent(
      content: contentController.text,
      imageUrl: imageUrlController.text,
    );
  }

  // Hàm xóa nội dung
  void clear() {
    contentController.clear();
    imageUrlController.clear();
  }
}*/