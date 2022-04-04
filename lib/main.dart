// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final double defaultPadding = 5.0;
  const MyApp({Key? key}) : super(key: key);

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
  const TimerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
      ),
      body: LayoutBuilder(builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
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
                      color: Colors.blue, text: "Work", onPressed: emptyMethod),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                    child: ProductivityButton(
                  color: Colors.green,
                  text: "Break",
                  onPressed: emptyMethod,
                )),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: Colors.red,
                    text: "Stop",
                    onPressed: emptyMethod,
                  ),
                ),
              ],
            ),
            Expanded(
              child: CircularPercentIndicator(
                radius: availableWidth / 3,
                lineWidth: 10.0,
                percent: 1.0,
                center: Text("30:00",
                    style: Theme.of(context).textTheme.displayMedium),
                progressColor: Color(0xFF4CAF50),
              ),
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
                    onPressed: emptyMethod,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(defaultPadding),
                ),
                Expanded(
                  child: ProductivityButton(
                    color: Colors.green,
                    text: "Restart",
                    onPressed: emptyMethod,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
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

void emptyMethod() {}
