import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    
    categories.add(CategoryModel(
      name: "AudioBooks",
      iconPath: "assets/icons/audiobook.svg",
      boxColor: Color.fromARGB(255, 233, 187, 187),
    ));
    categories.add(CategoryModel(
      name: "Romance",
      iconPath: "assets/icons/romance.svg",
      boxColor: Color.fromARGB(255, 166, 233, 222),
    ));
    categories.add(CategoryModel(
      name: "Fantasy",
      iconPath: "assets/icons/fantasy.svg",
      boxColor: Color.fromARGB(255, 176, 158, 240),
    ));
    categories.add(CategoryModel(
      name: "Science",
      iconPath: "assets/icons/science.svg",
      boxColor: Color.fromARGB(255, 252, 238, 178),
    ));
    
    return categories;
  }
}
