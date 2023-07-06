// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:light/light.dart';
import 'package:provider/provider.dart';
import 'package:sparrow/helpers/DarkMode/dark_provider.dart';

class LightScreen extends StatefulWidget {
  @override
  _LightScreenState createState() => new _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  String _luxString = 'Unknown';
  late Light _light;
  late StreamSubscription _subscription;

  void onData(int luxValue) async {
    setState(() {
      _luxString = "$luxValue";
    });
     final provider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    if (luxValue < 15) {
      provider.toggleTheme(true);
    } else {
      provider.toggleTheme(false);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  void startListening() {
    _light = new Light();
    try {
      _subscription = _light.lightSensorStream.listen(onData);
    } on LightException catch (exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  _changeTheme() {
    final provider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    // provider.toggleTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Light Example App'),
          actions: [
            Switch.adaptive(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  _changeTheme();
                })
          ],
        ),
        body: new Center(
          child: new Text('Lux value: $_luxString\n'),
        ),
      ),
    );
  }
}
