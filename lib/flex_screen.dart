import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlexScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FlexScreenState();
  }

}

class FlexScreenState extends State<FlexScreen>{

  var listText = ["Adi", "Budi", "Tati"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.yellow,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: listViewWidget(),
        ),
      ),
    );
  }

  columnWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Pertama"),
        Text("Kedua"),
        Text("Ketiga"),
      ],
    );
  }

  rowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pertama"),
        Text("Kedua"),
        Text("Ketiga"),
      ],
    );
  }

  stackWidget(){
    return Stack(
      children: [
        Container(width: 500, height: 500, color: Colors.red,),
        Container(width: 300, height: 300, color: Colors.blue,),
        Container(width: 200, height: 200, color: Colors.green,),
      ],
    );
  }

  listViewWidget(){
    return ListView(
      children: [
        ListTile(
          leading: Container(color: Colors.blue, width: 50, height: 50,),
          title: Text("Pengirim"),
          subtitle: Text("Chat Terakhir"),
          trailing: Icon(Icons.more_vert),
        ),
      ],
    );


  }

}