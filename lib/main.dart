import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/ClassifyPage.dart';
import 'package:flutter_app/pages/RecommendPage.dart';
import 'package:flutter_app/pages/SubjectPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {

  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));
  int tabIndex = 0;
  var tabImages;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Burqa',
        theme: new ThemeData(
            primaryColor: const Color(0xFF63CA6C)
        ),
        home: new Scaffold(
            body: body(),
            bottomNavigationBar: new CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                new BottomNavigationBarItem(
                    icon: getTabIcon(0),
                    title: new Text("分类")),
                new BottomNavigationBarItem(
                    icon: getTabIcon(1),
                    title: new Text("推荐")),
                new BottomNavigationBarItem(
                    icon: getTabIcon(2),
                    title: new Text("专题"))
              ],
              currentIndex: tabIndex,
              onTap: (index) {
                setState(() {
                  tabIndex = index;
                });
              },
            )
        )
    );
  }

  IndexedStack body() {
    return new IndexedStack(
      children: <Widget>[
        new ClassifyPage(),
        new RecommendPage(),
        new SubjectPage()
      ],
      index: tabIndex,
    );
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == tabIndex) {
      return tabImage(curIndex)[1];
    }
    return tabImage(curIndex)[0];
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  tabImage(int curIndex) {
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('images/ic_main_favorite_default.png'),
          getTabImage('images/ic_main_favorite_selected.png')
        ],
        [
          getTabImage('images/ic_main_recommend_default.png'),
          getTabImage('images/ic_main_recommend_selected.png')
        ],
        [
          getTabImage('images/ic_main_schedule_default.png'),
          getTabImage('images/ic_main_schedule_selected.png')
        ]
      ];
    }
    return tabImages[curIndex];
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 70.0, height: 70.0);
  }
}
