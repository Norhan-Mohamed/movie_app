import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String columnname = 'name';
final String columnid = 'id';

class EmailDataProvider {
  late Database db;

  static final EmailDataProvider instance = EmailDataProvider._internal();

  factory EmailDataProvider() {
    return instance;
  }
  EmailDataProvider._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'person.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table PersonTable ( 
$columnid integer ,
$columnname text not null,


  )
''');
    });
  }

  Future<List<FavDataBaseModel>> getData() async {
    List<Map<String, dynamic>> maps = await db.query('PersonTable');
    if (maps.isEmpty)
      return [];
    else {
      List<FavDataBaseModel> favproducts = [];
      maps.forEach((element) {
        favproducts
            .add(FavDataBaseModel.fromMap(element as Map<String, dynamic>));
      });
      print(maps);
      return favproducts;
    }
  }

  Future<FavDataBaseModel> insert(FavDataBaseModel dataBaseModel) async {
    dataBaseModel.id = await db.insert('PersonTable', dataBaseModel.toMap());
    return dataBaseModel;
  }

  Future<int> delete(int id) async {
    return await db
        .delete('PersonTable', where: '$columnid = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
