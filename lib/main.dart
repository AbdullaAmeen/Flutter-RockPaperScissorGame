import 'package:flutter/material.dart';
import 'package:task_1/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'R.P.S GAME'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int p1Ch = -1, p2Ch = -1;
  String p1Img = 'assets/1.png', p2Img = 'assets/1.png';
  TextEditingController player1 = TextEditingController();
  TextEditingController player2 = TextEditingController();
  bool ignore = false;
  int _gameState = 0;
  int winner = -9;
  String player1_name = "Player 1";
  String player2_name = "Player 2";

  void _changeGameState() {
    player1_name = player1.text == '' ? player1_name : player1.text;
    player2_name = player2.text == '' ? player2_name : player2.text;
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_gameState == 1) {
        _gameState = 0;
      } else {
        _gameState = 1;
      }
    });
  }

  void _determineWinner() async {
    setState(() {
      ignore = true;
    });
    winner = p1Ch - p2Ch;
    winner = winner == 2 ? -1 : winner;
    winner = winner == -2 ? 1 : winner;
    print(winner);
    await Future.delayed(const Duration(seconds: 1));
    String winnerTxt = "";
    switch (winner) {
      case 1:
        winnerTxt = "$player1_name Wins!";
        break;
      case -1:
        winnerTxt = "$player2_name Wins!";
        break;
      case 0:
        winnerTxt = "You both lose :) jk its a draw";
        break;
    }
    setState(() {
      p1Ch = -1;
      p2Ch = -1;
      winner = -9;
    });

    final returnInfo = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultPage(winner: winnerTxt)),
    );
    setState(() {
      ignore = false;
      if (returnInfo == 1)
        _gameState = 1;
      else
        _gameState = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: IgnorePointer(
            ignoring: ignore,
            child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Invoke "debug painting" (press "p" in the console, choose the
                // "Toggle Debug Paint" action from the Flutter Inspector in Android
                // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                // to see the wireframe for each widget.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  if (_gameState == 0) ...[
                    const Text(
                      'Enter Player Names',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: player1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        controller: player2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: FloatingActionButton(
                        onPressed: _changeGameState,
                        tooltip: 'Play',
                        child: const Icon(Icons.play_arrow),
                      ),
                    ),
                  ] else if (_gameState == 1) ...[
                    Text(
                      player1_name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              p1Ch = 1;
                              p1Img = "assets/1.png";
                              if (p1Ch != -1 && p2Ch != -1) _determineWinner();
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white10, // Splash color over image
                          child: Ink.image(
                            fit: BoxFit.cover, // Fixes border issues
                            width: 100,
                            height: 100,
                            image: const AssetImage(
                              'assets/1.png',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              p1Ch = 2;
                              p1Img = "assets/2.png";
                              if (p1Ch != -1 && p2Ch != -1) _determineWinner();
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white10, // Splash color over image
                          child: Ink.image(
                            fit: BoxFit.cover, // Fixes border issues
                            width: 100,
                            height: 100,
                            image: const AssetImage(
                              'assets/2.png',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              p1Ch = 3;
                              p1Img = "assets/3.png";
                              if (p1Ch != -1 && p2Ch != -1) _determineWinner();
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white10, // Splash color over image
                          child: Ink.image(
                            fit: BoxFit.cover, // Fixes border issues
                            width: 100,
                            height: 100,
                            image: const AssetImage(
                              'assets/3.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        if (p1Ch != -1) ...[
                          Image(
                            image: AssetImage(p1Img),
                            height: 100,
                          ),
                        ],
                        if (p2Ch != -1) ...[
                          Image(
                            image: AssetImage(p2Img),
                            height: 100,
                          ),
                        ],
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              p2Ch = 1;
                              p2Img = "assets/1.png";
                              if (p1Ch != -1 && p2Ch != -1) _determineWinner();
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white10, // Splash color over image
                          child: Ink.image(
                            fit: BoxFit.cover, // Fixes border issues
                            width: 100,
                            height: 100,
                            image: const AssetImage(
                              'assets/1.png',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              p2Ch = 2;
                              p2Img = "assets/2.png";
                              if (p1Ch != -1 && p2Ch != -1) _determineWinner();
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white10, // Splash color over image
                          child: Ink.image(
                            fit: BoxFit.cover, // Fixes border issues
                            width: 100,
                            height: 100,
                            image: const AssetImage(
                              'assets/2.png',
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              p2Ch = 3;
                              p2Img = "assets/3.png";
                              if (p1Ch != -1 && p2Ch != -1) _determineWinner();
                            });
                          }, // Image tapped
                          splashColor:
                              Colors.white10, // Splash color over image
                          child: Ink.image(
                            fit: BoxFit.cover, // Fixes border issues
                            width: 100,
                            height: 100,
                            image: const AssetImage(
                              'assets/3.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      player2_name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ]
                ])),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
