import 'package:flutter/material.dart';

import '../views/description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular TV Shows',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tv.length,
              itemBuilder: (context, index) {
                final movie = tv[index];
                final posterPath = movie['backdrop_path'] ?? '';
                final title = movie['original_name'] ?? 'No Title';
                final voterCount = movie['vote_count']??'';

                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Description(name: tv[index]['original_name'], description: tv[index]['overview'], bannerurl: 'http://image.tmdb.org/t/p/w500'+tv[index]['backdrop_path'], posterurl: 'http://image.tmdb.org/t/p/w500'+tv[index]['poster_path'], vote: voterCount.toString(), launch_on: tv[index]['first_air_date'])));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // padding: EdgeInsets.all(5.0),
                          width: 230,
                          height: 135,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
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
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

