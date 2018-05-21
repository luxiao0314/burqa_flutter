import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/RecommendPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {

  var appBarTitles = ['推荐', '分类', '专题'];
  final tabTextStyleNormal = new TextStyle(color: const Color(0xff969696));
  final tabTextStyleSelected = new TextStyle(color: const Color(0xff63ca6c));
  int tabIndex = 0;
  var tabImages;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.white70,
        ),
        home: new Scaffold(
            body: body(),
            bottomNavigationBar: new CupertinoTabBar(
              items: <BottomNavigationBarItem>[
                new BottomNavigationBarItem(
                    icon: getTabIcon(0),
                    title: getTabTitle(0)),
                new BottomNavigationBarItem(
                    icon: getTabIcon(1),
                    title: getTabTitle(1)),
                new BottomNavigationBarItem(
                    icon: getTabIcon(2),
                    title: getTabTitle(2)),
                new BottomNavigationBarItem(
                    icon: getTabIcon(3),
                    title: getTabTitle(3)),
              ],
            )
        )
    );
  }

  IndexedStack body() {
    return new IndexedStack(
      children: <Widget>[
        new RecommendPage()
      ],
      index: tabIndex,
    );
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == tabIndex) {
      return tabImage([curIndex][1]);
    }
    return tabImage([curIndex][0]);
  }

  getTabTitle(int curIndex) {
    return new Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image tabImage(int index) {
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
    return tabImages[index];
  }

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }
}
