import 'package:flutter/material.dart';
import 'package:medical_project/models/article.dart';
import 'package:medical_project/user/services/searchArticle.dart';


class ArticleSearchScreen extends StatefulWidget {
  @override
  _ArticleSearchScreenState createState() => _ArticleSearchScreenState();
}

class _ArticleSearchScreenState extends State<ArticleSearchScreen> {

  final _searchController = TextEditingController();
  List<Article> _searchResults = [];

  // Instance của lớp ArticleSearch
  final ArticleSearch _articleSearch = ArticleSearch();

  void _search() async {
    String searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      List<Article> results = await _articleSearch.searchArticles(searchTerm);
      setState(() {
        _searchResults = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Tìm kiếm bài viết...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _search,
            child: Text('Search'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                Article article = _searchResults[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text('Posted on: ${article.datePosted.toDate()}'),
                  onTap: () {
                    // Chuyển đến chi tiết bài viết nếu cần
                  },
                );
              },
            ),
          ),
        ]));
  }
}
