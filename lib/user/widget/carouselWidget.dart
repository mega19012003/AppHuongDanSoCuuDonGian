import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CusCarousel extends StatelessWidget {
  final List<Map<String, String>> featuredPosts = [
    {
      "image": "https://picsum.photos/800/400", // URL ảnh thay đổi kích thước
      "title": "post Title 1",
      "description": "Short description for post 1.",
    },
    {
      "image": "https://picsum.photos/800/400", // URL ảnh thay đổi kích thước
      "title": "post Title 2",
      "description": "Short description for post 2.",
    },
    {
      "image": "https://picsum.photos/800/400", // URL ảnh thay đổi kích thước
      "title": "post Title 3",
      "description": "Short description for post 3.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bài viết nổi bật",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        CarouselSlider(
          options: CarouselOptions(
            height: 200, // Chiều cao carousel
            enlargeCenterPage: true, // Phóng to item ở giữa
            autoPlay: false, // Không tự động chạy
            viewportFraction: 1.0, // Chiều ngang 100% màn hình
            aspectRatio: 16 / 9, // Tỉ lệ khung hình
          ),
          items: featuredPosts.map((post) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width, // Độ rộng item bằng toàn màn hình
                  margin: EdgeInsets.symmetric(horizontal: 0), // Không có margin ngang
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(post["image"]!),
                      fit: BoxFit.cover, // Ảnh bao phủ toàn bộ container
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4), // Lớp phủ tối
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          post["title"]!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          post["description"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
