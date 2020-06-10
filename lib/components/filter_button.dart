import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  FilterButton({this.colour, this.title, this.onPress});

  final Color colour;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Center(child: Text(title)),
        ),
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
