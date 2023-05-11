import 'package:movie_app/models/favScreenModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String columnrank = 'rank';
final String columntitle = 'title';
final String columnthumbnail = 'thumbnail';
final String columnrating = 'rating';
final String columnid = 'id';
final String columnyear = 'year';
final String columnimage = 'image';
final String columndescription = 'description';
final String columntrailer = 'trailer';
final String columnimdbid = 'imdbid';

class FavDataProvider {
  late Database db;

  static final FavDataProvider instance = FavDataProvider._internal();

  factory FavDataProvider() {
    return instance;
  }
  FavDataProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'favMovie.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table FavMovieTable ( 

$columnrank integer,
$columntitle text not null,
$columnthumbnail text,
$columnrating text,
$columnid text,
$columnyear integer,
$columnimage text,
$columndescription text,
$columntrailer text,
$columnimdbid text

)
''');
    });
  }

  Future<List<FavScreenModel>> getData() async {
    List<Map<String, dynamic>> maps = await db.query('FavMovieTable');
    if (maps.isEmpty)
      return [];
    else {
      List<FavScreenModel> favmovie = [];
      maps.forEach((element) {
        favmovie.add(FavScreenModel.fromJson(element as Map<String, dynamic>));
      });
      print(maps);
      return favmovie;
    }
  }

  Future<FavScreenModel> insert(FavScreenModel favScreenModel) async {
    favScreenModel.id =
        (await db.insert('FavMovieTable', favScreenModel.toJson())) as String;
    return favScreenModel;
  }

  Future<int> delete(String? id) async {
    return await db
        .delete('FavMovieTable', where: '$columnid = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
