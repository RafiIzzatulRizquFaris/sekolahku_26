
import 'package:sekolahku_26/repository/repository.dart';
import 'package:sekolahku_26/services/service.dart';

Repository repository = Repository();
Service service = Service(repository);

class AppService{
  static Service get getService {
    return service;
  }
}