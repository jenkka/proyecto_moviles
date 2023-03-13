import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/main_provider.dart';

class MyLoadingScreen extends StatelessWidget {
  final Widget child;

  const MyLoadingScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (context.watch<MainProvider>().isSearching())
          const Opacity(
            opacity: 0.7,
            child: ModalBarrier(dismissible: false),
          ),
        if (context.watch<MainProvider>().isSearching())
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
