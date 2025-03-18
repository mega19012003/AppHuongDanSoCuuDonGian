import 'package:flutter/material.dart';
//import 'package:medical_project/user/screen/testScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/user/screens/ArticleScreen.dart';
import 'package:medical_project/user/widget/articleCard.dart';
import 'package:medical_project/user/widget/carouselWidget.dart';
import 'package:medical_project/user/widget/search.dart'; // Import SearchBar
import 'package:flutter/material.dart';

class ListArticlePage extends StatelessWidget {
  const ListArticlePage({Key? key}) : super(key: key);
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
              /*TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),*/

              // Carousel placeholder
              //CusCarousel(),
              /*SizedBox(height: 16),*/

              // Recent posts section
              Text(
                "Tất cả bài viết",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 8),

              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('articles')
                    //.orderBy('datePosted', descending: true) // Sắp xếp theo ngày đăng giảm dần
                    //.limit(5) // Giới hạn 5 bài viết
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




/*class ServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Options'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          // Option 2
          ElevatedButton(
            onPressed: () {
              //print("Option 2 được chọn");
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => optionScreen()),
              );*/
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), // Kéo dài button hết chiều ngang
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.place, size: 20), // Icon trước chữ
                  SizedBox(width: 10),        // Khoảng cách giữa icon và chữ
                  Text("Bệnh viện gần nhất"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10), // Khoảng cách giữa các button

          // Option 3
          ElevatedButton(
            onPressed: () {
              //print("Option 3 được chọn");
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => optionScreen()),
              );*/
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), // Kéo dài button hết chiều ngang
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.call, size: 20), // Icon trước chữ
                  SizedBox(width: 10),        // Khoảng cách giữa icon và chữ
                  Text("Cấp Cứu Y Tế"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10), // Khoảng cách giữa các button

          // Option 4
          ElevatedButton(
            onPressed: () {
              //print("Option 4 được chọn");
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => optionScreen()),
              );*/
            },
            style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, 50), // Kéo dài button hết chiều ngang
              //side: BorderSide(color: Colors.red, width: 2), //đổi màu viền button
            ),
            child: Align (
              alignment: Alignment.centerLeft,
              child: Text("Option 3",
                  /*style: TextStyle(
                    color: Colors.redAccent,
                  )*/
              ),

            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ServicePage(),
  ));
}*/
