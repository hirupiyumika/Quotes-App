import 'package:flutter/material.dart';

class AuthorWediget extends StatelessWidget {
  final String text;
  final Color? color;
  const AuthorWediget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height / 14,
      decoration: BoxDecoration(
        color: const Color(0xFFedf0f8),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Center(
        child: Text(text, style: TextStyle(
          fontSize: 20, color: color,
        ),),
      ),
    );
  }
}
