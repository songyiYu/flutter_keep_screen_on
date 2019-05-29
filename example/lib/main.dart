import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:screen_keep_on/screen_keep_on.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool _isOn = await ScreenKeepOn.isOn;

    setState(() {
      isOn = _isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Screen Keep On Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Screen Keep On : $isOn\n'),
              Container(height: 10.0,),
              Checkbox(value: isOn, onChanged: (bool on){
                ScreenKeepOn.turnOn(on);
                setState((){isOn = on; });
              })
            ],
          ),
//          child: Text('Screen Keep On : $isOn\n'),
        ),
      ),
    );
  }
}
