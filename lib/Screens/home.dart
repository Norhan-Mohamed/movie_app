import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/models/favScreenModel.dart';
import 'package:movie_app/network/apiRequest.dart';
import 'package:movie_app/network/favoriteDataBase.dart';

import '../models/topMoviesModel.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexCategory = -1;
  List indexList = [0, 1, 2, 3, 4, 5, 6, 7, 8];
  String category = '';
  late Future<ListOfTops> _moviesFuture;

  List categories = [
    "comedy",
    "action",
    "tragedy",
    "horror",
    "drama",
    "documentary",
    "animation",
    "adventure",
    "science fiction",
  ];

  @override
  void initState() {
    super.initState();
    _moviesFuture = ApiTopMovies().apiData();
  }

  List<TopMoviesModel> _filteredMovies(List<TopMoviesModel> tops) {
    if (indexCategory < 0 || category.isEmpty) {
      return tops;
    }
    final selected = category.toLowerCase();
    return tops
        .where((movie) =>
            movie.genre.any((g) => g.toLowerCase().contains(selected)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.primaryColor,
        body: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 25,
            bottom: 5,
          ),
          child: FutureBuilder<ListOfTops>(
            future: _moviesFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error
                              .toString()
                              .replaceFirst('Exception: ', ''),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 48,
                          width: 140,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.secondryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _moviesFuture = ApiTopMovies().apiData();
                              });
                            },
                            child: const Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                final movies = _filteredMovies(snapshot.data!.tops);
                final images = snapshot.data!.tops
                    .take(7)
                    .map((movie) => movie.image)
                    .toList();
                return Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: 300.0,
                          enlargeCenterPage: true,
                          aspectRatio: 16 / 9,
                          viewportFraction: .7,
                          initialPage: 1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (position, reason) {},
                          enableInfiniteScroll: false,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale),
                      items: images.map<Widget>((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: 400,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(i),
                                        fit: BoxFit.cover)));
                          },
                        );
                      }).toList(),
                    ),
                    const Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(left: 8, bottom: 20, top: 20),
                        ),
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              indexCategory = indexList[index];
                              category = categories[index];
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(23),
                              color: Colors.black26,
                              border: Border.all(
                                  color: indexCategory == indexList[index]
                                      ? Constants.secondryColor
                                      : Constants.primaryColor,
                                  width: 2),
                            ),
                            child: Center(
                                child: Text(
                              categories[index],
                              style: const TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 10,
                        ),
                        itemCount: categories.length,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: movies.isEmpty
                          ? const Center(
                              child: Text(
                                'No movies in this category',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                height: 8,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: movies.length,
                              itemBuilder: (context, index) {
                                final movie = movies[index];
                                final heroTag = 'photo${movie.id}';
                                return Container(
                                  color: Colors.black26,
                                  padding: const EdgeInsets.all(5),
                                  child: Center(
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () => Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsPage(
                                                            heroTag: heroTag,
                                                            rank: movie.rank,
                                                            title: movie.title,
                                                            thumbnail:
                                                                movie.thumbnail,
                                                            rating:
                                                                movie.rating,
                                                            id: movie.id,
                                                            year: movie.year,
                                                            image: movie.image,
                                                            description: movie
                                                                .description,
                                                            trailer:
                                                                movie.trailer,
                                                            genre: movie.genre,
                                                            director:
                                                                movie.director,
                                                            writers: movie
                                                                .writers))),
                                            child: Hero(
                                              tag: heroTag,
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    color: Colors.black54,
                                                    border: Border.all(
                                                      color: Constants
                                                          .primaryColor,
                                                      width: 3,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15.0))),
                                                child: Image.network(
                                                  movie.image,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Flexible(
                                            child: Column(children: [
                                              Text(
                                                movie.title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                movie.genre.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                softWrap: false,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                            ]),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 90,
                                                  width: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      movie.rating,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      maxLines: 2,
                                                      softWrap: false,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15),
                                                    ),
                                                    const Icon(
                                                      Icons.star,
                                                      color:
                                                          Colors.yellowAccent,
                                                      size: 15,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.favorite,
                                                size: 26,
                                                color: Constants.secondryColor),
                                            onPressed: () async {
                                              await FavDataProvider.instance
                                                  .insert(FavScreenModel(
                                                      rank: movie.rank,
                                                      title: movie.title,
                                                      thumbnail:
                                                          movie.thumbnail,
                                                      rating: movie.rating,
                                                      id: movie.id,
                                                      year: movie.year,
                                                      image: movie.image,
                                                      description:
                                                          movie.description,
                                                      trailer: movie.trailer,
                                                      imdbid: movie.imdbid));
                                              Fluttertoast.showToast(
                                                  msg: 'Added to favourites');
                                            },
                                          ),
                                        ]),
                                  ),
                                );
                              }),
                    ),
                  ],
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Constants.secondryColor,
                ),
              );
            }),
        ),
    );
  }
}
