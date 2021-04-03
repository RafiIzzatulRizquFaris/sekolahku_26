import 'package:sekolahku_26/utils/capitalize.dart';

class Domain {

  static const genders = ["pria", "wanita"];
  static const grades = ["TK", "SD", "SMP", "SMA"];
  static const hobbieList = ["membaca", "menulis", "menggambar"];

  int idSiswa;
  String firstName;
  String lastName;
  String mobilePhone;
  String gender;
  String grade;
  String address;
  List<String> hobbies;

  String get fullName {
    return "${capitalize(firstName)} ${capitalize(lastName)}";
  }

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'grade': grade,
      'address': address,
      'mobile_phone': mobilePhone,
      'hobbies': hobbies.join(", "),
    };
    return map;
  }

  fromMap(Map<String, dynamic> valueDB){
    idSiswa = valueDB['id_siswa'];
    firstName = valueDB['first_name'];
    lastName = valueDB['last_name'];
    gender = valueDB['gender'];
    grade = valueDB['grade'];
    address = valueDB['address'];
    mobilePhone = valueDB['mobile_phone'];
    hobbies = valueDB['hobbies'].split(', ');
  }

}