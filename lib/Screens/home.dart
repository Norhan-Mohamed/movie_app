import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
  late String category = '';
  String initial = 'comedy';
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.primaryColor,
        body: FutureBuilder<ListOfTops>(
            future: ApiTopMovies().ApiData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                print(snapshot.data!.tops);
                List<String> images = [
                  snapshot.data!.tops[0].image,
                  snapshot.data!.tops[1].image,
                  snapshot.data!.tops[2].image,
                  snapshot.data!.tops[3].image,
                  snapshot.data!.tops[4].image,
                  snapshot.data!.tops[5].image,
                  snapshot.data!.tops[6].image,
                ];
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
                                // width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(i),
                                        fit: BoxFit.cover)));
                          },
                        );
                      }).toList(),
                    ),
                    Row(
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
                              initial = categories[index];
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
                              style: TextStyle(color: Colors.white),
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
                    SizedBox(
                      height: 6,
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                height: 8,
                              ),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.tops.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: Colors.black26,
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => DetailsPage(
                                                rank: snapshot
                                                    .data!.tops[index].rank,
                                                title: snapshot
                                                    .data!.tops[index].title,
                                                thumbnail: snapshot.data!
                                                    .tops[index].thumbnail,
                                                rating: snapshot
                                                    .data!.tops[index].rating,
                                                id: snapshot
                                                    .data!.tops[index].id,
                                                year: snapshot
                                                    .data!.tops[index].year,
                                                image: snapshot
                                                    .data!.tops[index].image,
                                                description: snapshot.data!
                                                    .tops[index].description,
                                                trailer: snapshot.data!.tops[index].trailer,
                                                genre: snapshot.data!.tops[index].genre,
                                                director: snapshot.data!.tops[index].director,
                                                writers: snapshot.data!.tops[index].writers))),
                                        child: Hero(
                                          tag: 'photo$index',
                                          child: Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                color: Colors.black54,
                                                border: Border.all(
                                                  color: Constants.primaryColor,
                                                  width: 3,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            child: Image.network(
                                              "${snapshot.data!.tops[index].image}",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        child: Column(children: [
                                          Text(
                                            snapshot.data!.tops[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            snapshot.data!.tops[index].genre
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15),
                                          ),
                                        ]),
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 90,
                                              width: 20,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!.tops[index].rating,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.yellowAccent,
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
                                          await FavDataProvider.instance.insert(
                                              FavScreenModel(
                                                  rank: snapshot
                                                      .data!.tops[index].rank,
                                                  title: snapshot
                                                      .data!.tops[index].title,
                                                  thumbnail: snapshot.data!
                                                      .tops[index].thumbnail,
                                                  rating: snapshot
                                                      .data!.tops[index].rating,
                                                  id: snapshot
                                                      .data!.tops[index].id,
                                                  year: snapshot
                                                      .data!.tops[index].year,
                                                  image: snapshot
                                                      .data!.tops[index].image,
                                                  description: snapshot.data!
                                                      .tops[index].description,
                                                  trailer: snapshot.data!
                                                      .tops[index].trailer,
                                                  imdbid: snapshot.data!
                                                      .tops[index].imdbid));
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
              ;

              return Center(
                child: CircularProgressIndicator(
                  color: Constants.primaryColor,
                ),
              );
            }));
  }
}
