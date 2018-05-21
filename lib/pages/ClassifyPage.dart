import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/Api.dart';
import 'package:flutter_app/utils/Net.dart';

class ClassifyPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new ClassifypageState();
  }
}

class ClassifypageState extends State<StatefulWidget> {

  var listData;
  TextStyle titleTextStyle = new TextStyle(fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    Widget listView = new ListView.builder(
      itemCount: listData.length,
      itemBuilder: (context, i) => renderRow(i),
//      controller: _controller,
    );
    return new RefreshIndicator(child: listView, onRefresh: pullToRefresh);
  }

  Future<Null> pullToRefresh() async {
    getData();
    return null;
  }


  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Net.get(Api.classify + "3262/0/1.json", (data) {
      if (data != null) {
        setState(() {
          listData = json.decode(data);
        });
      }
    }, errorCallback: (e) {
      print("get news list error: $e");
    });
  }

  Widget renderRow(int i) {
    return new InkWell(
      child: row(i),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (ctx) => null
        ));
      },
    );
  }

  Widget row(int i) {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Column(
              children: <Widget>[
                titleRow(i)
              ],
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Container(
//            width: 100.0,
//            height: 80.0,
//            color: const Color(0xFFECECEC),
            child: new Center(
              child: thumbImg(i),
            ),
          ),
        )
      ],
    );
  }

  Widget titleRow(int i) {
    var itemData = listData[i];
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Text(itemData['title'], style: titleTextStyle),
        )
      ],
    );
  }

  Widget thumbImg(int i) {
    var itemData = listData[i];
    var thumbImgUrl = itemData['cover'];
    var thumbImg = new Container(
      margin: const EdgeInsets.all(10.0),
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFECECEC),
        image: new DecorationImage(
            image: new ExactAssetImage('./images/ic_img_default.jpg'), //本地图片
            fit: BoxFit.cover),
        border: new Border.all(
          color: const Color(0xFFECECEC),
          width: 2.0,
        ),
      ),
    );
    if (thumbImgUrl != null && thumbImgUrl.length > 0) {
      var header = new Map<String, String>();
      header["Referer"] = "http://v2.api.dmzj.com";
      thumbImg = new Container(
        margin: const EdgeInsets.all(10.0),
        width: 60.0,
        height: 60.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFECECEC),
          image: new DecorationImage(
              image: new NetworkImage(thumbImgUrl, headers: header),
              fit: BoxFit.cover), //网络取图片
          border: new Border.all(
            color: const Color(0xFFECECEC),
            width: 2.0,
          ),
        ),
      );
    }
    return thumbImg;
  }
}