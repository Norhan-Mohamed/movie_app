import 'package:flutter/material.dart';
import 'package:movie_app/constant.dart';
import 'package:movie_app/models/topMoviesModel.dart';
import 'package:movie_app/network/apiRequest.dart';
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
  late TopMoviesModel _movie;
  bool _loadingDetails = true;

  static const _font = 'FontsFree-Net-SFProText-Regular.ttf';

  @override
  void initState() {
    super.initState();
    _movie = TopMoviesModel(
      rank: widget.rank,
      title: widget.title,
      thumbnail: widget.thumbnail,
      rating: widget.rating,
      id: widget.id,
      year: widget.year,
      image: widget.image,
      description: widget.description,
      trailer: widget.trailer,
      genre: widget.genre,
      director: widget.director,
      writers: widget.writers,
      imdbid: '',
    );
    _setupTrailer(_movie.trailer);
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final detailed = await ApiTopMovies().apiDataById(widget.id);
      if (!mounted) return;
      setState(() {
        _movie = detailed;
        _loadingDetails = false;
      });
      _setupTrailer(detailed.trailer);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loadingDetails = false;
      });
    }
  }

  void _setupTrailer(String trailerUrl) {
    final videoId = _convertedUrl(trailerUrl);
    if (videoId.isEmpty) {
      _controller?.dispose();
      _controller = null;
      return;
    }
    if (_controller != null && _controller!.initialVideoId == videoId) {
      return;
    }
    _controller?.dispose();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _convertedUrl(String url) {
    if (url.isEmpty) return '';
    return YoutubePlayer.convertUrlToId(url) ?? '';
  }

  String _joinList(List<String> values) {
    if (values.isEmpty) return 'N/A';
    return values.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Padding(
        padding: EdgeInsets.only(top: topInset + 16),
        child: Hero(
          tag: widget.heroTag,
          child: Material(
            type: MaterialType.transparency,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 340,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Constants.secondryColor,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            _movie.image,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.black45,
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.white54,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Material(
                          color: Colors.black45,
                          shape: const CircleBorder(),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: Constants.secondryColor,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _movie.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontFamily: _font,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white70,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.yellowAccent,
                        ),
                        child: const Text(
                          'IMDb',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: _font,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _movie.rating,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: _font,
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                        size: 18,
                      ),
                      const Spacer(),
                      Text(
                        '${_movie.year}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: _font,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _movie.genre
                        .map(
                          (g) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white24,
                              ),
                            ),
                            child: Text(
                              g,
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily: _font,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: _font,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _movie.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: _font,
                      color: Colors.white70,
                      height: 1.45,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (_loadingDetails) ...[
                    const SizedBox(height: 16),
                    const Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Constants.secondryColor,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  _infoBlock('Director', _joinList(_movie.director)),
                  const SizedBox(height: 10),
                  _infoBlock('Writer', _joinList(_movie.writers)),
                  const SizedBox(height: 24),
                  const Text(
                    'Trailer',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: _font,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_controller != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller!,
                        ),
                        builder: (context, player) => player,
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Trailer not available',
                          style: TextStyle(
                            color: Colors.white54,
                            fontFamily: _font,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoBlock(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: _font,
              color: Constants.secondryColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: _font,
              color: Colors.white,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
