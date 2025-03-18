import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/user/screens/ArticleScreen.dart';
import 'package:medical_project/user/widget/articleCard.dart';
import 'package:medical_project/user/widget/carouselWidget.dart';
import 'package:medical_project/user/widget/search.dart'; // Import SearchBar
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fast-Aid', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Carousel placeholder
              //CusCarousel(),
              SizedBox(height: 16),

              // Recent posts section
              Text(
                "Bài viết mới",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),

              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('articles')
                    .orderBy('datePosted', descending: true) // Sắp xếp theo ngày đăng giảm dần
                    .limit(5) // Giới hạn 5 bài viết
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final articles = snapshot.data!.docs.map((doc) {
                    return Article.fromMap(doc.data() as Map<String, dynamic>, doc.id);
                  }).toList();

                  if (articles.isEmpty) {
                    return const Center(child: Text('No articles found.'));
                  }

                  return ListView.builder(
                    shrinkWrap: true, // Không chiếm toàn bộ không gian
                    physics: const NeverScrollableScrollPhysics(), // Không cuộn riêng
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        child: ListTile(
                          title: Text(article.title),
                          subtitle: Text(
                            'Posted on: ${article.datePosted.toDate()}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            // Xử lý khi nhấn vào bài viết
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticleDetailPage(article: article),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


