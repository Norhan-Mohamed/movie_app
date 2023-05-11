import 'package:flutter/material.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/models/topMoviesModel.dart';
import 'package:movie_app/network/apiRequest.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  late int rank;
  late String title;
  late String thumbnail;
  late String rating;
  late String id;
  late int year;
  late String image;
  late String description;
  late String trailer;
  late List<String> genre;
  late List<String> director;
  late List<String> writers;
  late String imdbid;
  DetailsPage({
    super.key,
    required this.rank,
    required this.title,
    required this.thumbnail,
    required this.rating,
    required this.id,
    required this.year,
    required this.image,
    required this.description,
    required this.trailer,
    required this.genre,
    required this.director,
    required this.writers,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller =
        YoutubePlayerController(initialVideoId: ConvertedUrl(widget.trailer));
    super.initState();
  }

  String ConvertedUrl(url) {
    return YoutubePlayer.convertUrlToId(url).toString();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Hero(
        tag: 'photo',
        child: SingleChildScrollView(
          child: FutureBuilder<ListOfTops>(
              future: ApiTopMovies().ApiData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Constants.secondryColor,
                              size: 35,
                            )),
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 300,
                              child: Wrap(children: [
                                Text(
                                  widget.title,
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily:
                                          'FontsFree-Net-SFProText-Regular.ttf',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                            ),
                          ),
                          Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                            size: 20,
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.yellowAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    "IMBD",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily:
                                            'FontsFree-Net-SFProText-Regular.ttf',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.rating,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily:
                                          'FontsFree-Net-SFProText-Regular.ttf',
                                      color: Colors.yellowAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.year.toString() + ".R . 2h 20m",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily:
                                      'FontsFree-Net-SFProText-Regular.ttf',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.genre.toString(),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily:
                                      'FontsFree-Net-SFProText-Regular.ttf',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.description,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                      'FontsFree-Net-SFProText-Regular.ttf',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Director: " + widget.director.toString(),
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily:
                                      'FontsFree-Net-SFProText-Regular.ttf',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Writer: " + widget.writers.toString(),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily:
                                      'FontsFree-Net-SFProText-Regular.ttf',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Trailer",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily:
                                      'FontsFree-Net-SFProText-Regular.ttf',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            color: Colors.black26,
                            child: YoutubePlayerBuilder(
                              player: YoutubePlayer(
                                controller: _controller,
                              ),
                              builder: (context, player) {
                                return YoutubePlayer(controller: _controller);
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
                return Center(
                    child: Container(
                  child: CircularProgressIndicator(
                    color: Constants.secondryColor,
                  ),
                  height: 100,
                  width: 100,
                ));
              }),
        ),
      ),
    );
  }
}
