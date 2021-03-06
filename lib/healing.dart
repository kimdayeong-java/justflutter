import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '타이머',
      theme: ThemeData(

        primarySwatch: Colors.indigo,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '타이머'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index =0;
  var _pages=[
    Page1(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('타이머'),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios),
        bottom: PreferredSize(
          child:Text('쉬는시간',
              style: TextStyle(color: Colors.white, fontSize: 15.0),),
          preferredSize: null,
        ),
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _index=index;
          });
        },
        currentIndex: _index,
        items:<BottomNavigationBarItem> [
          BottomNavigationBarItem(
            title: Text('메인'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('타이머'),
            icon: Icon(Icons.timer),
          ),
        ],
      ),
    );
  }
}
class Page1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        _buildTop1(),
        _buildTop0(),
        _buildBottom(),

      ],
    );
  }
}
//상단
Widget _buildTop1(){
  return Center(
    child: Text(
      '명상',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
Widget _buildTop0() {
  return Column(
    children: <Widget>[
      Image.asset('images/heal.png',
        width: 256,
        height: 256,),
    ],
  );
}
@override
class MyHomePage1 extends StatefulWidget {
  MyHomePage1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePage1State createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> with TickerProviderStateMixin {
  AnimationController _controller;
  int levelClock = 180;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Countdown(
              animation: StepTween(
                begin: levelClock, // THIS IS A USER ENTERED NUMBER
                end: 0,
              ).animate(_controller),
            ),
          ],
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key key, this.animation}) : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inHours.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inMinutes.remainder(60).toString().padLeft(2, '0')}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    print('animation.value  ${animation.value} ');
    print('inHours ${clockTimer.inHours.toString()}');
    print('inHours.remainder ${clockTimer.inHours.remainder(60).toString()}');
    print('inMinutes ${clockTimer.inMinutes.toString()}');
    print('inMinutes.remainder ${clockTimer.inMinutes.remainder(60).toString()}');
    print('inSeconds ${clockTimer.inSeconds.toString()}');
    print('inSeconds.remainder ${clockTimer.inSeconds.remainder(60).toString()}');

    return Text(
      "$timerText",
      style: TextStyle(
        fontSize: 30,
        color: Colors.black,
      ),
    );
  }
}


_buildBottom(){
  return Center(
    child:Text(
      '명상을 통해 지친 몸을 달래 주세요!',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}