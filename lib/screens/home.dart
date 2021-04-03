import 'package:flutter/material.dart';
import 'package:sekolahku_26/domain/domain.dart';
import 'package:sekolahku_26/screens/detail.dart';
import 'package:sekolahku_26/screens/form.dart';
import 'package:sekolahku_26/services/app_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSearch = false;
  String searchValue;
  Widget appBarTitle = Text(
    "SekolahKu",
    style: TextStyle(
      color: Colors.white,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: appBarTitle,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              if (isSearch) {
                setState(() {
                  isSearch = false;
                  searchValue = null;
                  appBarTitle = Text(
                    "SekolahKu",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                });
              } else {
                setState(() {
                  isSearch = true;
                  appBarTitle = TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: "Cari Siswa",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        searchValue = value;
                      });
                    },
                  );
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Domain>>(
        future: AppService.getService.readData(searchValue),
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Text("Tidak ada data"),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          detailStudent: snapshot.data[index],
                        ),
                      ));
                },
                leading: Image.asset(
                  snapshot.data[index].gender == "pria"
                      ? "assets/images/pria.png"
                      : "assets/images/wanita.png",
                  height: 50,
                  width: 50,
                ),
                title: Text(snapshot.data[index].fullName),
                subtitle: Text(snapshot.data[index].gender),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.data[index].grade),
                    Text(snapshot.data[index].mobilePhone),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.grey,
              );
            },
            itemCount: snapshot.data.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.create,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(
                isUpdate: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
