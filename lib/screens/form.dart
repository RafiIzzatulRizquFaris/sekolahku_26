import 'package:flutter/material.dart';
import 'package:sekolahku_26/domain/domain.dart';
import 'package:sekolahku_26/screens/home.dart';
import 'package:sekolahku_26/services/app_service.dart';
import 'package:sekolahku_26/utils/capitalize.dart';
import 'package:sekolahku_26/widgets/custom_checkbox.dart';
import 'package:sekolahku_26/widgets/custom_radio.dart';

class FormScreen extends StatefulWidget {
  final bool isUpdate;
  final Domain dataDomain;

  const FormScreen({
    Key key,
    this.isUpdate,
    this.dataDomain,
  }) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String gender;
  String grade;

  List<String> valueHobbies = <String>[];

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      firstNameController.text = widget.dataDomain.firstName;
      lastNameController.text = widget.dataDomain.lastName;
      mobilePhoneController.text = widget.dataDomain.mobilePhone;
      addressController.text = widget.dataDomain.address;
      gender = widget.dataDomain.gender;
      grade = widget.dataDomain.grade;
      valueHobbies = widget.dataDomain.hobbies;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Tambah Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: firstNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Nama Depan Tidak Boleh Kosong";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nama Depan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    controller: lastNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Nama Belakang Tidak Boleh Kosong";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Nama Belakang",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mobilePhoneController,
              validator: (value) {
                if (value.isEmpty) {
                  return "No HP Tidak Boleh Kosong";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "No. HP",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Jenis Kelamin",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            Row(
              children: Domain.genders
                  .map((e) => CustomRadio(
                        activeColor: Colors.amber,
                        value: e,
                        label: Text(capitalize(e)),
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButton<String>(
              items: Domain.grades
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                      ),
                    ),
                  )
                  .toList(),
              value: grade,
              onChanged: (value) {
                setState(() {
                  grade = value;
                });
              },
              hint: Text(
                "Pilih Jenjang",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Hobi",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            Column(
              children: Domain.hobbieList
                  .map((e) => CustomCheckBox(
                        value: valueHobbies.contains(e),
                        label: Text(e),
                        onChanged: (value) {
                          setState(() {
                            if (valueHobbies.contains(e)) {
                              valueHobbies.remove(e);
                            } else {
                              valueHobbies.add(e);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 5,
              controller: addressController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Alamat Tidak Boleh Kosong";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Alamat",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
        onPressed: () {
          if (formKey.currentState.validate()) {
            if (gender != null && grade != null && valueHobbies.isNotEmpty) {
              Domain domain = Domain();
              domain.firstName = firstNameController.text.trim();
              domain.lastName = lastNameController.text.trim();
              domain.mobilePhone = mobilePhoneController.text.trim();
              domain.address = addressController.text.trim();
              domain.grade = grade;
              domain.gender = gender;
              domain.hobbies = valueHobbies;

              if (widget.isUpdate) {
                AppService.getService
                    .updateData(domain, widget.dataDomain.idSiswa)
                    .then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                }).catchError((error) {
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        "Data Gagal disimpan",
                      ),
                    ),
                  );
                });
              } else {
                AppService.getService.createData(domain).then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                }).catchError((error) {
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        "Data Gagal disimpan",
                      ),
                    ),
                  );
                });
              }
            } else {
              scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text("Isi Semua Data")));
            }
          } else {
            scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text("Isi Semua Data")));
          }
        },
      ),
    );
  }
}
