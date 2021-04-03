import 'package:flutter/material.dart';
import 'package:sekolahku_26/domain/domain.dart';
import 'package:sekolahku_26/screens/form.dart';
import 'package:sekolahku_26/screens/home.dart';
import 'package:sekolahku_26/services/app_service.dart';

class Detail extends StatefulWidget {
  final Domain detailStudent;

  const Detail({Key key, this.detailStudent}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
          "Detail Siswa",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormScreen(
                    isUpdate: true,
                    dataDomain: widget.detailStudent,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.create,
            ),
          ),
          IconButton(
            onPressed: () {
              AppService.getService
                  .deleteData(widget.detailStudent.idSiswa)
                  .then(
                    (value) => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    ),
                  );
            },
            icon: Icon(
              Icons.delete,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(widget.detailStudent.gender == "pria"
                ? "assets/images/pria.png"
                : "assets/images/wanita.png"),
          )
        ],
      ),
    );
  }
}
