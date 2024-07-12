import 'package:flutter/material.dart';

class GridBlock extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const GridBlock({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              imagePath,
              height: 80.0,
              width: 80.0,
            ),
          ],
        ),
      ),
    );
  }
}
