import 'package:flutter/material.dart';
import 'package:movie_app/views/description.dart';

class TopRated extends StatelessWidget {
  final List toprated;

  const TopRated({Key? key, required this.toprated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Rated Movies',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: toprated.length,
              itemBuilder: (context, index) {
                final movie = toprated[index];
                final posterPath = movie['poster_path'] ?? '';
                final title = movie['title'] ?? 'No Title';
                final rating = movie['vote_average']??'';
                final voterCount = movie['vote_count']??'';

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(name: toprated[index]['original_title'], description: toprated[index]['overview'], bannerurl: 'http://image.tmdb.org/t/p/w500'+toprated[index]['backdrop_path'], posterurl: 'http://image.tmdb.org/t/p/w500'+toprated[index]['poster_path'], vote: voterCount.toString(), launch_on: toprated[index]['release_date'])));
                  },
                  child: toprated[index]['name']==null?Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: posterPath.isNotEmpty
                                  ? NetworkImage('http://image.tmdb.org/t/p/w500' + posterPath)
                                  : const AssetImage('assets/placeholder.png') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 1,),
                        Text(
                          'Rating: '+ rating.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Reviews: '+voterCount.toString(),
                          style: const TextStyle(
                            color: Colors.amber,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ):Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
