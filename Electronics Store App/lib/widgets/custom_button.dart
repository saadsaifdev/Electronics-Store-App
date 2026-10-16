import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  const CustomButon({
    super.key, 
    required this.onTap, 
    required this.text,
  });

  final String text;
  final VoidCallback? onTap; 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF2B475E),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}