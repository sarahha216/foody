import 'package:foody/data/models/food_basket.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper{
  Database? _database;

  String _dbName = "FoodyDB2.db";
  int _version = 1;

  Future<Database?> get database async{
    if(_database!=null){
      return _database;
    }
    _database = await getInstance();
  }
  Future<Database> getInstance() async {
    String path = join(await getDatabasesPath(), _dbName);
    return _database = await openDatabase(
        path,
        version: _version,
        onCreate: createDatabase);
  }

  createDatabase(Database db, int version) async{
    await db.execute("CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        " name TEXT NOT NULL, image TEXT NOT NULL, "
        " price INTEGER NOT NULL, rate INTEGER NOT NULL, "
        " resKey TEXT NOT NULL, foodKey TEXT NOT NULL,"
        " quantity INTEGER NOT NULL, sum REAL NOT NULL)");
  }
  Future<FoodBasket> insertChat(FoodBasket foodBasket) async {
    var dbCart = await database;
    await dbCart!.insert('cart', foodBasket.toJson());
    return foodBasket;
  }

  Future<List<FoodBasket>> getFoodList() async{
    await database;
    final List<Map<String, Object?>> QueryResult =
    await _database!.rawQuery("SELECT * FROM cart");
    return QueryResult.map((e) => FoodBasket.fromJson(e)).toList();
  }

  Future<int> delete(int id) async{
    var dbCart = await database;
    return await dbCart!.delete('cart',
        where: 'id = ?',
        whereArgs: [id],
    );
  }

}