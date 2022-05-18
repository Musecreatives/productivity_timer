// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:productivity_app/settings.dart';
import './timer.dart';
import './models/timerModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();
  final double defaultPadding = 5.0;
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();
  final List<PopupMenuItem<String>> menuItems = [
    PopupMenuItem<String>(
      value: 'Settings',
      child: Text('Settings'),
    ),
  ];

  TimerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('My Work Timer'),
            actions: [
              PopupMenuButton(itemBuilder: (BuildContext context) {
                return menuItems.toList();
              }, onSelected: (s) {
                if (s == 'Settings') {
                  goToSettings(context);
                }
              }),
            ],
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Colors.blue,
                        text: "Work",
                        onPressed: () => timer.startWork(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                        child: ProductivityButton(
                      color: Colors.green,
                      text: "Break",
                      onPressed: () => timer.startBreak(true),
                    )),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Colors.red,
                        text: "Stop",
                        onPressed: () => timer.startBreak(false),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    )
                  ],
                ),
                Expanded(
                  child: StreamBuilder(
                      initialData: '00:00',
                      stream: timer.stream(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        TimerModel timer = (snapshot.data == '00:00')
                            ? TimerModel('00:00', 1)
                            : snapshot.data;
                        return Expanded(
                          child: CircularPercentIndicator(
                            radius: availableWidth / 3,
                            lineWidth: 10.0,
                            percent: timer.percent,
                            center: Text(timer.time,
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            progressColor: Color(0xFF4CAF50),
                          ),
                        );
                      }),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Colors.red,
                        text: "Stop",
                        onPressed: () => timer.stopTimer(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(defaultPadding),
                    ),
                    Expanded(
                      child: ProductivityButton(
                        color: Colors.green,
                        text: "Restart",
                        onPressed: () => timer.startTimer(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          })),
    );
  }
}

class ProductivityButton extends StatelessWidget {
  const ProductivityButton(
      {Key? key, this.color, this.text, this.size, this.onPressed})
      : super(key: key);
  final Color? color;
  final String? text;
  final double? size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      child: Text(
        text!,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
      minWidth: size,
    );
  }
}

void goToSettings(BuildContext context) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => const Settings()));
}
