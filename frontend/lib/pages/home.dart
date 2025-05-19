import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bookstore/models/category_model.dart';
import 'package:bookstore/models/book_model.dart';
import 'package:flutter/services.dart';
import 'package:bookstore/pages/favourites.dart';
import 'package:bookstore/pages/settings_pages/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  List<CategoryModel> categories = [];
  List<dynamic> popularBooks = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    categories = CategoryModel.getCategories();
    fetchPopularBooks();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchPopularBooks() async {
    final backendUrl = dotenv.env['BACKEND_URL'];
    final response = await http.get(
      Uri.parse('$backendUrl/popular'),
      headers: {'Authorization': 'Bearer ${dotenv.env['ACCESS_TOKEN']}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> booksJson = json.decode(response.body);
      setState(() {
        popularBooks =
            booksJson.map((book) => BookModel.fromJson(book)).toList();
      });
    } else {
      print('Failed to load books');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: [_homePageContent(), FavoritesPage(), SettingsPage()],
      ),
      bottomNavigationBar: _navigationSection(),
    );
  }

  Widget _navigationSection() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      iconSize: 24,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }

  Widget _homePageContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBar(),
          _searchField(),
          SizedBox(height: 30),
          _categoriesSection(),
          SizedBox(height: 35),
          _popularBooksSection(),
          SizedBox(height: 35),
        ],
      ),
    );
  }

  Widget _popularBooksSection() {
    const crossAxisCount = 2;
    const aspectRatio = 0.45;
    const horizontalPadding = 20.0;

    if (popularBooks.isEmpty) {
      return Center(heightFactor: 10, child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: Text(
            "Popular Books",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
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
          itemCount: popularBooks.length,
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
                      popularBooks[index].coverImagePath,
                      height: 180,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    popularBooks[index].title,
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
                    "Author : ${popularBooks[index].author}",
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
                    "Genre : ${popularBooks[index].genre}",
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
                    "Pages : ${popularBooks[index].pages}",
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
                    "Description : \n${popularBooks[index].description}",
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
    );
  }

  Widget _categoriesSection() {
    const horizontalPadding = 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: Text(
            "Category",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 130,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            separatorBuilder: (context, index) => SizedBox(width: 25),
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    const horizontalPadding = 20.0;

    return Container(
      margin: EdgeInsets.only(
        top: 40,
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff1D1617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Stack(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "Arial",
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 60,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => print("Pressed filter button"),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/Filter.svg", height: 20),
                  SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              height: double.infinity,
              child: GestureDetector(
                onTap: () => print("Pressed search button"),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(40),
                  ),
                  child: Container(
                    width: 50,
                    color: Color(0xffF7F8F8),
                    padding: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    const horizontalPadding = 0.0;

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("Pressed back button");
              },
              child: Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  "assets/icons/ArrowLeft.svg",
                  height: 20,
                  width: 20,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Bookstore',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Pressed menu button");
              },
              child: Container(
                margin: EdgeInsets.all(10),
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset("assets/icons/dots.svg", height: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
