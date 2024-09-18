import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import '../widgets/topRated.dart';
import '../widgets/trending.dart';
import '../widgets/tv.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];
  final String apiKey = '960b2fbf9ee90f294e8754a0db9dc192';
  final readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjBiMmZiZjllZTkwZjI5NGU4NzU0YTBkYjlkYzE5MiIsIm5iZiI6MTcyMzUwMTU4OS4zMTE4ODgsInN1YiI6IjY2YmE4NzQyMjlhZDFhMGVhOTFhZDllZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.k0MMy0-vKDvH5i9hcJ06nD4raxLEnyLVfzRFHzK99rw';

  void initState(){
    loadMovies();
    super.initState();
  }

  loadMovies()async{    //asynchronous means it can perform operations that take some time (like network requests) without blocking the main thread.
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),    //TMDB is class  probably responsible for managing interactions with the TMDB API.
        logConfig: const ConfigLogger(     //The logConfig parameter expects an instance of ConfigLogger, which is used to configure logging options.
          showLogs: true,
          showErrorLogs: true,
        )
    );


    //DIRECTLY FROM API WE WILL GET A MAP *print(trendingResult)* SO WE HAVE TO CONVERT IT INTO LIST *print(trendingMovies)*

    Map trendingResult = await tmdbWithCustomLogs.v3.trending.getTrending(); //getTrending function gives me trending DICTIONARY
    Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResult = await tmdbWithCustomLogs.v3.tv.getPopular();


    //IN ORDER TO CHANGE THE STATE OF ABOVE CREATED MAPS INTO LIST WE USE SETSTATE
    setState(() {
      trendingMovies = trendingResult['results'];
      topRatedMovies = topRatedResults['results'];
      tv = tvResult['results'];
    });
    print(topRatedMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        title: const Center(child: Text('Cine-Groove',style: TextStyle(color: Colors.black,fontSize: 30),)),
      ),
      body: ListView(
        children: [
          TopRated(toprated: topRatedMovies,), //calls the constructor of TopRated from *topRated.dart*
          TrendingMovies(trending: trendingMovies), //calls the constructor of TrendingMovies from *trending.dart*
          TV(tv: tv), //calls the constructor of TV from *tv.dart*
        ],
      ),
    );
  }
}

