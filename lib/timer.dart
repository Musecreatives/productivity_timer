import 'dart:async';
import './models/timerModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  Timer? timer;
  Duration? _time;
  Duration? _fullTime;
  int work = 30;
  int shortBreak = 5;
  int longBreak = 20;

  String returnTime(Duration t) {
    String minutes = (t.inMinutes < 10)
        ? '0' + t.inMinutes.toString()
        : t.inMinutes.toString();
    int numSeconds = t.inSeconds - (t.inMinutes * 60);
    String seconds =
        (numSeconds < 10) ? '0' + numSeconds.toString() : numSeconds.toString();
    String formattedTime = minutes + ":" + seconds;
    return formattedTime;
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time! - const Duration(seconds: 1);
        _radius = _time!.inSeconds / _fullTime!.inSeconds;
        if (_time!.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time!);
      return TimerModel(time, _radius);
    });
  }
// read the settings

  Future readSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    work = (prefs.getInt('workTime') == null ? 30 : prefs.getInt('workTime'))!;
    shortBreak =
        (prefs.getInt('shortBreak') == null ? 30 : prefs.getInt('shortBreak'))!;
    longBreak =
        (prefs.getInt('longBreak') == null ? 30 : prefs.getInt('longBreak'))!;

    void startWork() {
      _radius = 1;
      _time = Duration(minutes: work, seconds: 0);
      _fullTime = _time;
    }
  }

  void startWork() {
    _radius = 1;
    _time = Duration(minutes: work, seconds: 0);
    _fullTime = _time;
  }

  void stopTimer() {
    _isActive = false;
  }

  void startTimer() {
    if (_time!.inSeconds > 0) {
      _isActive = true;
    }
  }

  void startBreak(bool isShort) {
    _radius = 1;
    _time = Duration(
      minutes: (isShort) ? shortBreak : longBreak,
      seconds: 0,
    );
    _fullTime = _time;
  }
}
