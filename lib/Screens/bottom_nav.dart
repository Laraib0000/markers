import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trigon_application/Constants/colors.dart';
import 'package:trigon_application/Screens/plan_route_Screen.dart';
import 'package:trigon_application/Screens/route_option_screen.dart';

import 'find_evs_screen.dart';

class BottomNav extends StatefulWidget {
  final int index;
  BottomNav(this.index);

  @override
  State<StatefulWidget> createState() {
    return _BottomNavState();
  }
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 1;

  final tab = [RouteOption(), FindEVS(), PlanRoute()];

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          return _showExitDialogue(context);
        }
      },
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: redC,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            currentIndex: _currentIndex,
            // this will be set when a new tab is tapped
            items: const [
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location_circle),
                label: 'Route Option',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search_circle),
                label: 'Find EVS',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location),
                label: 'Plan Route',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          body: tab[_currentIndex]),
    );
  }

  _showExitDialogue(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          final screenSize = MediaQuery.of(context).size;
          return AlertDialog(
            insetPadding: EdgeInsets.all(30.0),
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0.0),
            content: Container(
              height: 150.0,
              width: screenSize.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 1.0,
                    ),
                    Text(
                      "Do you want to exit from app?",
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.8), fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: Container(
                            height: 45.0,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffff8218),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(0.0),
                          onPressed: () {
                            Navigator.pop(dialogContext);
                          },
                          child: Container(
                            height: 45.0,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xffff8218),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Text(
                                "No",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
