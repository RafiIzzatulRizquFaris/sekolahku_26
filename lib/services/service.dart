import 'package:sekolahku_26/domain/domain.dart';
import 'package:sekolahku_26/repository/repository.dart';

class Service{
  final Repository repository;

  Service(this.repository);

  Future<void> createData(Domain domain) async {
    return repository.createData(domain);
  }

  Future<List<Domain>> readData(String searchValue) async {
    return repository.readData(searchValue);
  }

  Future<void> updateData(Domain domain, int idSiswa) async {
    return repository.updateData(domain, idSiswa);
  }

  Future<void> deleteData(int idSiswa) async {
    return repository.deleteData(idSiswa);
  }
}