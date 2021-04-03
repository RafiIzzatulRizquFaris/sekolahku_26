import 'package:sekolahku_26/domain/domain.dart';
import 'package:sekolahku_26/models/model.dart';
import 'package:sekolahku_26/seeds/seed.dart';

class Repository {
  List<Domain> data = Seed().getDummyData();

  createData(Domain domain) {
    return Model().openDB().then(
          (db) => db.insert(
            "siswa",
            domain.toMap(),
          ),
        );
  }

  Future<List<Domain>> readData(String searchValue) async {
    var sqlRaw = '''
    SELECT * FROM siswa
    ''';

    if (searchValue != null){
      var value = '%$searchValue%';
      sqlRaw += '''
      
      WHERE 
      first_name LIKE '$value' OR
      last_name LIKE '$value' OR
      mobile_phone LIKE '$value' OR
      grade LIKE '$value' OR
      gender LIKE '$value' OR
      address LIKE '$value'
      
      ''';
    }

    return Model()
        .openDB()
        .then(
          (db) => db.rawQuery(sqlRaw),
        )
        .then(
      (data) {
        if (data.length == 0) {
          return [];
        }
        List<Domain> dataList = [];
        for (int i = 0; i < data.length; i++) {
          Domain domain = Domain();
          domain.fromMap(data[i]);
          dataList.add(domain);
        }
        return dataList;
      },
    );
  }

  Future<void> updateData(Domain domain, int idSiswa) async {
    return Model().openDB().then((db) => db.update(
          'siswa',
          domain.toMap(),
          where: 'id_siswa = $idSiswa',
        ));
  }

  Future<void> deleteData(int idSiswa) async {
    return Model().openDB().then((db) => db.delete(
          'siswa',
          where: 'id_siswa = $idSiswa',
        ));
  }
}
