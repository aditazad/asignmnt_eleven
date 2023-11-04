import 'dart:convert';
import 'package:asignmnt_eleven/screen/photo_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Photo Gallery App'),
        ),
        body: PhotoList(),
      ),
    );
  }
}

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  late Future<List<Photo>> futurePhotos;

  @override
  void initState() {
    super.initState();
    futurePhotos = fetchPhotos();
  }

  Future<List<Photo>> fetchPhotos() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Photo> photos = body.map((dynamic item) => Photo.fromJson(item)).toList();
        return photos;
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: futurePhotos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Photo>? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhotoDetails(
                        title: data[index].title,
                        imageUrl: data[index].url,
                        id: data[index].id,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: Image.network(
                      data[index].thumbnailUrl,
                      width: 50.0,
                      height: 50.0,
                    ),
                    title: Text(data[index].title),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({required this.id, required this.title, required this.url, required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}


