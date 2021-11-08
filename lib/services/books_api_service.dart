import 'dart:convert';

import 'package:take_home/constants/strings.dart';
import 'package:take_home/models/book_model.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  Future<BookModel> getBooks({String name = "Famous+books"}) async {
    var client = http.Client();

    
    //before getting started add your API key in constants/strings.dart
    String url =
        'https://www.googleapis.com/books/v1/volumes?q=$name&key=${OurStrings.apiKey}';
    late BookModel booksModel;

    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        booksModel = BookModel.fromJson(jsonMap);
      }
    } on Exception {
      throw Exception;
    }
    return booksModel;
  }
}
