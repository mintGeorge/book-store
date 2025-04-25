import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bookstore/models/category_model.dart';
import 'package:bookstore/models/book_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<BookModel> popularBooks = [];

  @override
  void initState() {
    super.initState();
    categories = CategoryModel.getCategories();
    popularBooks = BookModel.getPopularBooks();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBar(isLargeScreen),
            _searchField(isLargeScreen),
            SizedBox(height: isLargeScreen ? 15 : 30),
            _categoriesSection(isLargeScreen),
            SizedBox(height: isLargeScreen ? 20 : 35),
            _popularBooksSection(isLargeScreen),
            SizedBox(height: isLargeScreen ? 20 : 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: isLargeScreen ? 40 : 20),
                  child: Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: isLargeScreen ? 24 : 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: isLargeScreen ? 10 : 20),
                // Add your best sellers section here
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _popularBooksSection(bool isLargeScreen) {
    // Calculate responsive grid parameters
    final crossAxisCount = isLargeScreen ? 4 : 2;
    // Adjust aspect ratio to accommodate author text
    final aspectRatio = isLargeScreen ? 0.65 : 0.45;
    final horizontalPadding = isLargeScreen ? 
        MediaQuery.of(context).size.width * 0.1 : 20.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: Text(
            "Popular Books",
            style: TextStyle(
              fontSize: isLargeScreen ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: isLargeScreen ? 10 : 20),
        GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: isLargeScreen ? 30 : 20,
            mainAxisSpacing: isLargeScreen ? 20 : 15,
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
                  // Book cover image
                  Center(
                    child: Image.asset(
                      popularBooks[index].coverImagePath,
                      height: isLargeScreen ? 220 : 180,
                      width: isLargeScreen ? 170 : 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 12),
                  // Book title
                  Text(
                    popularBooks[index].title,
                    style: TextStyle(
                      fontSize: isLargeScreen ? 16 : 13,
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
                      fontSize: isLargeScreen ? 14 : 12,
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
                      fontSize: isLargeScreen ? 14 : 12,
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
                      fontSize: isLargeScreen ? 14 : 12,
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
                      fontSize: isLargeScreen ? 14 : 12,
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

  Widget _categoriesSection(bool isLargeScreen) {
    final horizontalPadding = isLargeScreen ? 
        MediaQuery.of(context).size.width * 0.1 : 20.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding),
          child: Text(
            "Category",
            style: TextStyle(
              fontSize: isLargeScreen ? 24 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: isLargeScreen ? 150 : 130,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            separatorBuilder: (context, index) => SizedBox(width: isLargeScreen ? 35 : 25),
            itemBuilder: (context, index) {
              return Container(
                width: isLargeScreen ? 120 : 100,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: isLargeScreen ? 60 : 50,
                      height: isLargeScreen ? 60 : 50,
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
                        fontSize: isLargeScreen ? 18 : 16,
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

  Widget _searchField(bool isLargeScreen) {
    final horizontalPadding = isLargeScreen ? 
        MediaQuery.of(context).size.width * 0.1 : 20.0;
    
    return Container(
      margin: EdgeInsets.only(
        top: isLargeScreen ? 20 : 40, 
        left: horizontalPadding, 
        right: horizontalPadding
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
                fontSize: isLargeScreen ? 18 : 16,
                fontFamily: "Arial",
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: isLargeScreen ? 22 : 18,
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
                  SvgPicture.asset(
                    "assets/icons/Filter.svg",
                    height: isLargeScreen ? 24 : 20,
                  ),
                  SizedBox(width: 10),
                  Container(
                    height: isLargeScreen ? 24 : 20,
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
                    width: isLargeScreen ? 60 : 50,
                    color: Color(0xffF7F8F8),
                    padding: EdgeInsets.all(isLargeScreen ? 14 : 12),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset(
                        "assets/icons/Search.svg",
                        height: isLargeScreen ? 24 : 20,
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

  Widget appBar(bool isLargeScreen) {
    final horizontalPadding = isLargeScreen ? 
      MediaQuery.of(context).size.width * 0.1 : 0.0;
    
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 15 : 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                print("Pressed back button");
              },
              child: Container(
                margin: EdgeInsets.all(isLargeScreen ? 12 : 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  "assets/icons/ArrowLeft.svg",
                  height: isLargeScreen ? 24 : 20,
                  width: isLargeScreen ? 24 : 20,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Bookstore',
                  style: TextStyle(
                    fontSize: isLargeScreen ? 36 : 30,
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
                margin: EdgeInsets.all(isLargeScreen ? 12 : 10),
                width: isLargeScreen ? 46 : 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  "assets/icons/dots.svg", 
                  height: isLargeScreen ? 6 : 5
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}