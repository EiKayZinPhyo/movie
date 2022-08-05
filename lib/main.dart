import 'dart:convert' as cnv;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MoviePage(),
    );
  }
}

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late List title;
  late List data;

  void getNowPlaying() async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=050c28541f900007285c3020069bfd62&language=en-US&page=1');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var title = jsonDecode(response.body);

      setState(() {
        data = title['results'];
      });
      print(data.toString());
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie app"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Movie',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          SizedBox(
            width: 500,
            height: 560,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return Card(
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Image.network(
                            // ignore: prefer_interpolation_to_compose_strings
                            'https://image.tmdb.org/t/p/original/' +
                                data[index]['backdrop_path']),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          '${data[index]['original_title']}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
