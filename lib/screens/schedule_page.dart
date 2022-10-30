import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/platform_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SchedulePage extends StatefulWidget {
  static const String searchTitle = 'Favorite Restaurant';

  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  // late SchedulingProvider scheduled;
  // static const String counterBoolPrefs = "counterNumber";

  // void _saveNumber() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(counterBoolPrefs, scheduled.isScheduled);
  // }

  // void _loadNumber() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     scheduled.isSChedule = prefs.getBool(counterBoolPrefs) ?? false;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadNumber();
  // }

  Widget _buildList(BuildContext context) {
    return ListView(
      children: [
        Material(
          child: ListTile(
            title: const Text('Scheduling News'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: scheduled.isScheduled,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      customDialog(context);
                      // _saveNumber;
                    } else {
                      scheduled.scheduledNews(value);
                      // _saveNumber;
                    }
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SchedulePage.searchTitle),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(SchedulePage.searchTitle),
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
