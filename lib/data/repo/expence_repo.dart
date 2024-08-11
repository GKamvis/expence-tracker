// ignore_for_file: non_constant_identifier_names

import 'package:myapp/data/dao/expence_dao.dart';
import 'package:myapp/data/sqflite/db_helper.dart';

class ExpenceRepository {
  Future<List<ExpenceDao>> getExpence() async {
    var db = await DbHelper.openDb();
    List<Map<String, dynamic>> expenceMap =
        await db.rawQuery('SELECT * FROM expence');

    return List.generate(expenceMap.length, (i) {
      var row = expenceMap[i];

      return ExpenceDao(
          Id: row['Id'], Name: row['Name'], Expences: row['Expences']);
    });
  }

  Future<void> addExpence(String ExpenceName, double ExpenceAmount) async {
    var db = await DbHelper.openDb();
    var data = <String, dynamic>{};
    data['Name'] = ExpenceName;
    data['Expences'] = ExpenceAmount;
   await  db.insert('expence', data);
  }

  Future<void> deleteExpence(int Id) async {
    var db = await DbHelper.openDb();
   await db.delete('expence', where: 'Id = ?', whereArgs: [Id]);
  }

  // Future<void> updateExpence(int Id, String Name, double Expences) async {
  //   var db = await DbHelper.openDb();

  //   var data = <String, dynamic>{};
  //   data['Name'] = Name;
  //   data['Expences'] = Expences;
  //   await db.update('expence', data, where: 'Id = ?', whereArgs: [Id]);
  // }
  Future<void> updateExpence(int Id, String Name, double Expences) async {
  var db = await DbHelper.openDb();

  var data = <String, dynamic>{};
  data['Name'] = Name;
  data['Expences'] = Expences;

  int count = await db.update('expence', data, where: 'Id = ?', whereArgs: [Id]);
  
  if (count == 0) {
    print("Update failed, no rows affected");
  } else {
    print("Update successful");
  }
}


  Future<List<ExpenceDao>> findExpence(String query) async {
    var db = await DbHelper.openDb();

    List<Map<String, dynamic>> expenceMap =
        await db.rawQuery("Select * from expence where Name like '%$query%'");

    return List.generate(expenceMap.length, (i) {
      var row = expenceMap[i];

      return ExpenceDao(
          Id: row['Id'], Name: row['Name'], Expences: row['Expences']);
    });
  }
}
