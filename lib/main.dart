import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyAppHome(),
    ); //MaterialApp
  }
}

class MyAppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppHomeState();
  }
}

class _MyAppHomeState extends State<MyAppHome> {
  int typedCharLength = 0;
  String userName = "";
  String lorem =
      '                                                                         Lorem Ipsum is simply dummy text of the printing and orem Ipsum is simply dummy text of the printing and orem Ipsum is simply dummy text of the printing and orem Ipsum is simply dummy text of the printing and  '
          .toLowerCase()
          .replaceAll(',', '')
          .replaceAll('.', '');
  int step = 0;
  int score = 0;
  int lastTypedAt;

  void updateLastTypedAt() {
    this.lastTypedAt = DateTime.now().millisecondsSinceEpoch;
  }

  void resetGame() {
    setState(() {
      typedCharLength = 0;
      step = 0;
    });
  }

  void onUserNameType(String value) {
    setState(() {
      this.userName = value.substring(0, 5);
    });
  }

  void onType(String value) {
    updateLastTypedAt();
    String trimmedValue = lorem.trimLeft();

    setState(() {
      if (trimmedValue.indexOf(value) != 0) {
        step = 2;
      } else {
        typedCharLength = value.length;
      }
    });
  }

  void onStartClick() {
    setState(() {
      updateLastTypedAt();
      step++;
    });
    var timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      int now = DateTime.now().millisecondsSinceEpoch;
      // Game Over

      setState(() {
        if (step == 1 && now - lastTypedAt > 4000) {
          step++;
        }
        if (step != 1) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var shownWidget;
    if (step == 0)
      shownWidget = <Widget>[
        Text("Merhaba Text Runner'a hoşgeldin"),
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            obscureText: false,
            onChanged: onUserNameType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Adın nedir acemi Text Runner?',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            child: Text('Başlamaya Hazır mısın?'),
            onPressed: userName.length == 0 ? null : onStartClick,
          ),
        ),
      ];
    else if (step == 1)
      shownWidget = <Widget>[
        Container(
          height: 40,
          child: Marquee(
            text: lorem,
            style: TextStyle(fontSize: 24, letterSpacing: 2),
            scrollAxis: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            blankSpace: 20.0,
            velocity: 75,
            pauseAfterRound: Duration(seconds: 15),
            startPadding: 0,
            accelerationDuration: Duration(seconds: 5),
            accelerationCurve: Curves.ease,
            decelerationDuration: Duration(milliseconds: 500),
            decelerationCurve: Curves.easeOut,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: TextField(
            obscureText: false,
            autofocus: true,
            onChanged: onType,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Başla',
            ),
          ),
        )
      ];
    else
      shownWidget = <Widget>[
        Text("Maalesef tamamlayamadın $userName, skorun : $typedCharLength "),
        ElevatedButton(onPressed: resetGame, child: Text('Yeniden Başla!'))
      ];
    return Scaffold(
        appBar: AppBar(
          title: Text('Text Runner'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: shownWidget),
        )
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Container(
        // child: new RichText(
        //   maxLines: 1,
        //   softWrap: false,
        //   text: new TextSpan(
        //     // Note: Styles for TextSpans must be explicitly defined.
        //     // Child text spans will inherit styles from parent
        //     style: new TextStyle(
        //       fontSize: 24,
        //       letterSpacing: 2,
        //     ),
        //     children: <TextSpan>[
        //       new TextSpan(text: 'Hello'),
        //       new TextSpan(
        //           text: lorem, style: new TextStyle(color: Colors.blue)),
        //       ],
        //     ),
        //   ),
        //   // Text(
        //   //   lorem,
        //   //   maxLines: 1,
        //   //   softWrap: false,
        //   //   style: TextStyle(fontSize: 24, letterSpacing: 2),
        //   // ),
        // ),

        );
  }
}
