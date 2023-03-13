import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/details_screen.dart';
import 'package:proyecto/providers/main_provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
        actions: [
          if (!context.watch<MainProvider>().getShowSearchBar())
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (() {
                context.read<MainProvider>().setShowSearchBar(true);
              }),
            )
        ],
      ),
      body: context.read<MainProvider>().getShowSearchBar()
          ? buildSearchBar(context)
          : buildBooks(context),
    );
  }

  Widget buildBooks(BuildContext context) {
    if (context.watch<MainProvider>().getItems().isEmpty) {
      return const Center(
          child: Text('The titles you search for will appear here.'));
    } else {
      return ListView.builder(
        itemCount: context.read<MainProvider>().getItems().length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    book: context.read<MainProvider>().getItems()[index],
                  ),
                ),
              );
            },
            leading: context.read<MainProvider>().getItems()[index].coverImg,
            title: Text(context.read<MainProvider>().getItems()[index].title),
            subtitle:
                Text(context.read<MainProvider>().getItems()[index].author),
          );
        },
      );
    }
  }

  Widget buildSearchBar(BuildContext context) {
    final focusNode = FocusNode();

    Future.delayed(
        Duration.zero, () => FocusScope.of(context).requestFocus(focusNode));

    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search for a title here',
      ),
      onSubmitted: (String value) {
        context.read<MainProvider>().setShowSearchBar(false);
        context.read<MainProvider>().getBooks(value);
      },
      focusNode: focusNode,
    );
  }
}
