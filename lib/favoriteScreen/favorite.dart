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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      appBar: AppBar(
        backgroundColor: Constants.secondryColor,
        title: Text(
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
          future: FavDataProvider.instance.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  //  height: 400,
                  child: GridView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      child: GestureDetector(
                    // onTap: () => Navigator.of(context)
                    //    .push(MaterialPageRoute()),
                    child: Hero(
                      tag: 'photo$index',
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.20, //145,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${snapshot.data![index].image}"),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].title.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily:
                                          'FontsFree-Net-SFProText-Regular.ttf',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                                Text(
                                  "rank: " +
                                      snapshot.data![index].rank.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily:
                                        'FontsFree-Net-SFProText-Regular.ttf',
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "year: " +
                                      snapshot.data![index].year.toString(),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontFamily:
                                        'FontsFree-Net-SFProText-Regular.ttf',
                                  ),
                                  maxLines: 1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "rate " +
                                          snapshot.data![index].rating
                                              .toString(),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontFamily:
                                            'FontsFree-Net-SFProText-Regular.ttf',
                                      ),
                                      maxLines: 1,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                      size: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    crossAxisSpacing: 20,
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 20),
              ));
            }
            if (snapshot.hasError) {
              print(snapshot.error!);
              return Container(
                child: Text(snapshot.error!.toString()),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Constants.primaryColor,
              ),
            );
          }),
    );
  }
}
