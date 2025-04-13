import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  const Paragraph({
    super.key,
    required this.paragraph,
    this.cutLine = false,
  });

  final bool? cutLine;
  final String paragraph;

  @override
  Widget build(BuildContext context) {
    return Text(
      paragraph,
      maxLines: cutLine == true ? 3 : null,
      overflow: cutLine == true ? TextOverflow.ellipsis : null,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      softWrap: true,
    );
  }
}
