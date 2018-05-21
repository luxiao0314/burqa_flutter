import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/Api.dart';
import 'package:flutter_app/utils/Net.dart';
import 'package:flutter_app/utils/ToastManager.dart';

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
    Widget listView = new GridView.count(
      crossAxisCount: 3,
      children: new List.generate(listData.length, (i) {
        return new GestureDetector(
            onTap: () {
              ToastManager.showToast("click");
            },
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                thumbImg(i),
                titleRow(i)
              ],
            )
        );
      }),
    );
    return new RefreshIndicator(child: listView, onRefresh: pullToRefresh);
  }

  Future<Null> pullToRefresh() async {
    getData();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    Net.get(Api.category, (data) {
      if (data != null) {
        setState(() {
          listData = json.decode(data);
        });
      }
    }, errorCallback: (e) {
      print("error: $e");
    });
  }

  Widget titleRow(int i) {
    var itemData = listData[i];
    return new Expanded(
      child: new Text(itemData['title'], style: titleTextStyle, maxLines: 1),
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