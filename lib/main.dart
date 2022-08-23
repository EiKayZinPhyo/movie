import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/page/detail.dart';
import 'package:movie_app/screen/firstpage.dart';
import 'package:movie_app/screen/register.dart';
import 'package:movie_app/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'firstpage',
        routes: {
          'firstpage': (context) => FirstPage(),
          'registerpage': (context) => RegisterPage(),
          'loginpage': (context) => LoginPage(),
          'moviepage': (context) => MoviePage(),
        });
  }
}

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late List title;
  late List data = [];

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
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Movie app"),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, 'firstpage');
            },
          ),
        ],
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'NowPlaying_Movie',
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
