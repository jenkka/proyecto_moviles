import 'package:flutter/material.dart';
import 'package:proyecto/schemes/book_scheme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/main_provider.dart';
import 'package:share/share.dart';

class DetailsScreen extends StatelessWidget {
  final Book book;

  const DetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
        actions: [
          IconButton(
              onPressed: () async {
                context.read<MainProvider>().setIsSearching(true);
                String url = book.buyLink;

                await launchUrl(Uri.parse(url));

                if (context.mounted) {
                  context.read<MainProvider>().setIsSearching(false);
                }
              },
              icon: const Icon(Icons.public)),
          IconButton(
              onPressed: () {
                Uri link = Uri.parse(book.googleLink);
                Share.share('Check out this book: $link');
              },
              icon: const Icon(Icons.share))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: book.coverImg,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  book.title,
                  style: const TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Published on: ${book.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Pages: ${book.pageN}'),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  book.description,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
