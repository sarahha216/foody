import 'package:foody/data/models/cart.dart';
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
        " foodName TEXT NOT NULL, foodImage TEXT NOT NULL, "
        " foodPrice INTEGER NOT NULL, foodRate INTEGER NOT NULL, "
        " resKey TEXT NOT NULL, foodKey TEXT NOT NULL,"
        " quantity INTEGER NOT NULL, sum REAL NOT NULL)");
  }
  Future<Cart> insertChat(Cart cart) async {
    var dbCart = await database;
    await dbCart!.insert('cart', cart.toJson());
    return cart;
  }

  Future<List<Cart>> getFoodList() async{
    await database;
    final List<Map<String, Object?>> QueryResult =
    await _database!.rawQuery("SELECT * FROM cart");
    return QueryResult.map((e) => Cart.fromJson(e)).toList();
  }

  Future<int> delete(int id) async{
    var dbCart = await database;
    return await dbCart!.delete('cart',
        where: 'id = ?',
        whereArgs: [id],
    );
  }

  //cách 1
  // Future<void> updateQuantity(int id, int quantity) async{
  //   var dbCart = await database;
  //   await dbCart!.rawUpdate(
  //     'UPDATE cart set quantity = ? WHERE id = ?',
  //     [quantity, id]
  //   );
  // }

  //cách 2
  Future<void> update(int id, int quantity, double price) async{
    var dbCart = await database;
    await dbCart!.update(
      'cart',
      {'quantity': quantity,
        'sum': quantity * price,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //update toàn bộ
  // Future<int> update(Cart cart) async{
  //   var dbCart = await database;
  //   return await dbCart!.update('cart',
  //     cart.toJson(),
  //     where: 'id = ?',
  //     whereArgs: [cart.id],
  //   );
  // }



}