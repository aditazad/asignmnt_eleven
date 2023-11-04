import 'package:flutter/material.dart';

class PhotoDetails extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int id;

  PhotoDetails({required this.title, required this.imageUrl, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ID: $id',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Image.network(imageUrl),
            SizedBox(height: 20),
            Text(
              'Title: $title',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}