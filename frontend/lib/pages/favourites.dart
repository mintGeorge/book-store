import 'dart:convert';

import 'package:bookstore/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List<dynamic> favoriteBooks = [];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 &&
          !_scrollController.position.outOfRange) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        );
      } else {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.grey),
        );
      }
    });
    fetchFavoriteBooks();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchFavoriteBooks() async {
    final backendUrl = dotenv.env['BACKEND_URL'];
    final response = await http.get(
      Uri.parse('$backendUrl/favorites'),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['ACCESS_TOKEN']}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> booksJson = json.decode(response.body);
      setState(() {
        favoriteBooks =
            booksJson.map((book) => BookModel.fromJson(book)).toList();
      });
    } else {
      print('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: _favoriteBooksSection(),
    );
  }
  Widget _favoriteBooksSection() {
    const crossAxisCount = 2;
    const aspectRatio = 0.45;
    const horizontalPadding = 20.0;

    if (favoriteBooks.isEmpty) {
      return Center(heightFactor: 10, child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      controller: _scrollController,
      child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text(
          "Favorites",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        )),
          SizedBox(height: 20),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 15,
              childAspectRatio: aspectRatio,
            ),
            itemCount: favoriteBooks.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        favoriteBooks[index].coverImagePath,
                        height: 180,
                        width: 130,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      favoriteBooks[index].title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Author : ${favoriteBooks[index].author}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                        fontFamily: "Arial",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Genre : ${favoriteBooks[index].genre}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                        fontFamily: "Arial",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Pages : ${favoriteBooks[index].pages}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                        fontFamily: "Arial",
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Description : \n${favoriteBooks[index].description}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                        fontFamily: "Arial",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

}

  