import 'package:flutter/material.dart';
import 'package:movie_app/models/favScreenModel.dart';

import '../constant.dart';
import '../network/favoriteDataBase.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    super.key,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late Future<List<FavScreenModel>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() {
    _favoritesFuture = FavDataProvider.instance.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Constants.secondryColor,
        title: const Text(
          "My Movies",
          style: TextStyle(
              fontFamily: 'FontsFree-Net-SFProText-Regular.ttf',
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 1),
        ),
      ),
      body: FutureBuilder<List<FavScreenModel>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No favourites yet',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final fav = snapshot.data![index];
                  return GestureDetector(
                    child: Hero(
                      tag: 'fav${fav.id}',
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      '${fav.image}',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.black45,
                                        child: const Icon(
                                          Icons.movie,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      onPressed: () async {
                                        await FavDataProvider.instance
                                            .delete(fav.id);
                                        setState(() {
                                          _loadFavorites();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Constants.secondryColor,
                                        size: 26,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              fav.title.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily:
                                    'FontsFree-Net-SFProText-Regular.ttf',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'rank: ${fav.rank}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 13,
                                fontFamily:
                                    'FontsFree-Net-SFProText-Regular.ttf',
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'year: ${fav.year}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily:
                                          'FontsFree-Net-SFProText-Regular.ttf',
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'rate ${fav.rating}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontFamily:
                                                'FontsFree-Net-SFProText-Regular.ttf',
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellowAccent,
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error!.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Constants.secondryColor,
              ),
            );
          }),
    );
  }
}
