import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  final String currentPage;

  Breadcrumb({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              // Navigate to home
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: Text('Trang chủ', style: TextStyle(color: Colors.blue)),
          ),
          Text(' > ', style: TextStyle(color: Colors.grey)),
          Text(currentPage, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}