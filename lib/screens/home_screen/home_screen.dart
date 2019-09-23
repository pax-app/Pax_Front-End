import 'package:flutter/material.dart';
import 'package:pax_front_end/components/drawer/drawer.dart';
import 'package:pax_front_end/screens/home_screen/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Container(color: Colors.red,),
        Container(color: Colors.green,),
        Container(color: Colors.purple,),
        Container(color: Colors.orange,),
        Container(color: Colors.blue,),
      ],
    );
  }
}