import 'package:flutter/material.dart';
import 'package:movie_app/constant.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailsPage extends StatefulWidget {
  final String heroTag;
  final int rank;
  final String title;
  final String thumbnail;
  final String rating;
  final String id;
  final int year;
  final String image;
  final String description;
  final String trailer;
  final List<String> genre;
  final List<String> director;
  final List<String> writers;

  const DetailsPage({
    super.key,
    required this.heroTag,
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
  YoutubePlayerController? _controller;
  late final String _videoId;

  @override
  void initState() {
    super.initState();
    _videoId = ConvertedUrl(widget.trailer);
    if (_videoId.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: _videoId,
        flags: const YoutubePlayerFlags(autoPlay: false),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String ConvertedUrl(String url) {
    if (url.isEmpty) return '';
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Hero(
        tag: widget.heroTag,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(
                        color: Constants.secondryColor, width: 2),
                  ),
                  height: 350,
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
                    child: SizedBox(
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
                  const Icon(
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
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                          color: Colors.yellowAccent,
                        ),
                        child: const Center(
                          child: Text(
                            "IMBD",
                            style: TextStyle(
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
                      "${widget.year}",
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
                      "Director: ${widget.director}",
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
                      "Writer: ${widget.writers}",
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Trailer",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily:
                              'FontsFree-Net-SFProText-Regular.ttf',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (_controller != null)
                    Container(
                      color: Colors.black26,
                      child: YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller!,
                        ),
                        builder: (context, player) {
                          return player;
                        },
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Trailer not available',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
