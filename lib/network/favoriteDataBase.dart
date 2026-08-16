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
    db = await openDatabase(
      join(await getDatabasesPath(), 'favMovie.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
create table FavMovieTable ( 
$columnrank integer,
$columntitle text not null,
$columnthumbnail text,
$columnrating text,
$columnid text primary key,
$columnyear integer,
$columnimage text,
$columndescription text,
$columntrailer text,
$columnimdbid text
)
''');
      },
    );
  }

  Future<List<FavScreenModel>> getData() async {
    List<Map<String, dynamic>> maps = await db.query('FavMovieTable');
    if (maps.isEmpty) {
      return [];
    }
    return maps.map((element) => FavScreenModel.fromJson(element)).toList();
  }

  Future<bool> isFavorite(String? id) async {
    if (id == null) return false;
    final maps = await db.query(
      'FavMovieTable',
      where: '$columnid = ?',
      whereArgs: [id],
      limit: 1,
    );
    return maps.isNotEmpty;
  }

  Future<FavScreenModel?> insert(FavScreenModel favScreenModel) async {
    if (favScreenModel.id == null) return null;
    if (await isFavorite(favScreenModel.id)) {
      return favScreenModel;
    }
    await db.insert('FavMovieTable', favScreenModel.toJson());
    return favScreenModel;
  }

  Future<int> delete(String? id) async {
    return await db
        .delete('FavMovieTable', where: '$columnid = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
