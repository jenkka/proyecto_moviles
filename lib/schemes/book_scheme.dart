import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final Image coverImg;
  final String pageN;
  final String year;
  final String description;
  final String buyLink;
  final String googleLink;

  Book(
      {required this.title,
      required this.author,
      required this.coverImg,
      required this.pageN,
      required this.year,
      required this.description,
      required this.googleLink,
      required this.buyLink});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        title: json['volumeInfo']['title'] ?? 'Unknown',
        author: json['volumeInfo']['authors'] != null
            ? json['volumeInfo']['authors'].join(', ')
            : 'Unknown',
        coverImg: Image(
          image: NetworkImage(json['volumeInfo']['imageLinks'] != null
              ? json['volumeInfo']['imageLinks']['thumbnail']
              : "http://books.google.com/books/content?id=aIsqAQAAMAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"),
        ),
        pageN: json['volumeInfo']['pageCount'] != null
            ? json['volumeInfo']['pageCount'].toString()
            : 'Unknown',
        year: json['volumeInfo']['publishedDate'] ?? 'Unknown',
        buyLink:
            json['saleInfo']['buyLink'] ?? json['volumeInfo']['previewLink'],
        googleLink:
            json['volumeInfo']['previewLink'] ?? json['volumeInfo']['title'],
        description: json['volumeInfo']['description'] ?? 'No description');
  }
}
