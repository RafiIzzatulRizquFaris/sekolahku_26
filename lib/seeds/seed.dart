import 'package:faker/faker.dart';
import 'package:sekolahku_26/domain/domain.dart';

class Seed{
  var faker = Faker();

  Domain getFaker(){
    var domain = Domain();
    domain.firstName = faker.person.firstName();
    domain.lastName = faker.person.lastName();
    domain.address = faker.address.streetAddress();
    domain.mobilePhone = "082299189919";
    domain.grade = Domain.grades[faker.randomGenerator.integer(4)];
    domain.gender = Domain.genders[faker.randomGenerator.integer(2)];
    domain.hobbies = Domain.hobbieList;
    return domain;
  }

  List<Domain> getDummyData([int max = 10]){
    List<Domain> data = <Domain>[];

    for (int i = 0; i < max; i++){
      data.add(getFaker());
    }

    return data;
  }

}