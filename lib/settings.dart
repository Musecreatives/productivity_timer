import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";
  int? workTime;
  int? shortBreak;
  int? longBreak;
  SharedPreferences? prefs;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }
//  user interface screen
  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontSize: 20);
    return Scaffold(
      body: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          const Text("Work", style: textStyle),
          const Text(""),
          const Text(""),
          SettingsButton(
              const Color(0xff455A64), "-", -1, WORKTIME, updateSetting),
          TextField(
            controller: txtWork,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
          ),
          SettingsButton(
              const Color(0xff009688), "+", 1, WORKTIME, updateSetting),
          const Text("Short", style: textStyle),
          const Text(""),
          const Text(""),
          SettingsButton(
              const Color(0xff455A64), "-", -1, SHORTBREAK, updateSetting),
          TextField(
              controller: txtShort,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
              const Color(0xff009688), "+", 1, SHORTBREAK, updateSetting),
          const Text(
            "Long",
            style: textStyle,
          ),
          const Text(""),
          const Text(""),
          SettingsButton(
              const Color(0xff455A64), "-", -1, LONGBREAK, updateSetting),
          TextField(
              controller: txtLong,
              style: textStyle,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number),
          SettingsButton(
              const Color(0xff009688), "+", 1, LONGBREAK, updateSetting),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    int? workTime = prefs?.getInt(WORKTIME);
    if (workTime == null) {
      await prefs?.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = prefs?.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs?.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = prefs?.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs?.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork?.text = workTime.toString();
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs?.getInt(WORKTIME);
          workTime = value;
          if (workTime >= 1 && workTime <= 180) {
            prefs?.setInt(WORKTIME, workTime);
            setState(() {
              txtWork?.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? shortBreak = prefs?.getInt(SHORTBREAK);
          shortBreak = value;
          if (shortBreak >= 1 && shortBreak <= 120) {
            prefs?.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtShort?.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs?.getInt(LONGBREAK);
          long = value;
          if (long >= 1 && long <= 180) {
            prefs?.setInt(LONGBREAK, long);
            setState(() {
              txtShort?.text = long.toString();
            });
          }
          break;
        }
    }
  }
}
