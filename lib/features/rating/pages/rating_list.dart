import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pingo/features/rating/models/rating.dart';
import 'package:pingo/widgets/design_list_tile.dart';

class RatingList extends StatelessWidget {
  const RatingList({Key? key, required this.ratings}) : super(key: key);

  final List<Rating> ratings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ratings.length,
      itemBuilder: (BuildContext context, int index) {
        final rating = ratings[index];

        return Container();
      },
    );
  }
}
