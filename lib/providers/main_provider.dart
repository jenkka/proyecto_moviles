import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../schemes/book_scheme.dart';

class MainProvider with ChangeNotifier {
  bool _showSearchBar = false;
  List<Book> _currentBooks = [];
  bool _searching = false;

  void setShowSearchBar(bool state) {
    _showSearchBar = state;
    notifyListeners();
  }

  bool getShowSearchBar() {
    return _showSearchBar;
  }

  void getBooks(String text) async {
    _searching = true;
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$text&maxResults=20';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> items = json['items'];

      List<Book> searchResults =
          items.map((item) => Book.fromJson(item)).toList();
      _currentBooks = searchResults;
      _searching = false;
      notifyListeners();
    } else {
      throw Exception('Could not retrieve books from API.');
    }
  }

  List<Book> getItems() {
    return _currentBooks;
  }

  bool isSearching() {
    return _searching;
  }

  void setIsSearching(bool state) {
    _searching = state;
  }
}
