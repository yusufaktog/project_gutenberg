import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database/crud.dart';

class Book {
  String coverImageUrl;
  String title;
  String author;
  int? bookmark;
  String? id;

  Book.previewed(this.coverImageUrl, this.title, this.author, this.bookmark, this.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Book && runtimeType == other.runtimeType && coverImageUrl == other.coverImageUrl;

  @override
  int get hashCode => coverImageUrl.hashCode;
}

class BookCard extends StatefulWidget {
  final Book book;
  final User? user;
  final bool inBookShelf;

  const BookCard({Key? key, required this.book, required this.user, required this.inBookShelf}) : super(key: key);

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  @override
  Card build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: widget.book.coverImageUrl.isNotEmpty ? Image.network(widget.book.coverImageUrl) : Image.asset("assets/no_image.png"),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 20.0),
                  child: Text(
                    widget.book.title,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    widget.book.author,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                IconButton(
                    onPressed: () {
                      widget.inBookShelf ? DatabaseHelper.removeBook(widget.book) : DatabaseHelper.addBook(widget.book);
                    },
                    icon: widget.inBookShelf ? const Icon(Icons.delete) : const Icon(Icons.add_rounded))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
