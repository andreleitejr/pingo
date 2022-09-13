import 'package:flutter/material.dart';
import 'package:pingo/core/keyword.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.keywords}) : super(key: key);

  final List<Keyword> keywords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: keywords.length,
        itemBuilder: (BuildContext context, int index) => Text(
          keywords[index].title,
        ),
      ),
    );
  }
}
