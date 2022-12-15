import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Cosinuss° One - Demo'),
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
  String _connectionStatus = "Disconnected";
  String _heartRate = "- bpm";
  String _bodyTemperature = '- °C';

  String _accX = "-";
  String _accY = "-";
  String _accZ = "-";

  String _ppgGreen = "-";
  String _ppgRed = "-";
  String _ppgAmbient = "-";

  bool _isConnected = false;

  bool earConnectFound = false;

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: [
                const Text(
                  'Status: ',
                ),
                Text(_connectionStatus),
              ]),
              Row(children: [
                const Text('Heart Rate: '),
                Text(_heartRate),
              ]),
              Row(children: [
                const Text('Body Temperature: '),
                Text(_bodyTemperature),
              ]),
              Row(children: [
                const Text('Accelerometer X: '),
                Text(_accX),
              ]),
              Row(children: [
                const Text('Accelerometer Y: '),
                Text(_accY),
              ]),
              Row(children: [
                const Text('Accelerometer Z: '),
                Text(_accZ),
              ]),
              Row(children: [
                const Text('PPG Raw Red: '),
                Text(_ppgRed),
              ]),
              Row(children: [
                const Text('PPG Raw Green: '),
                Text(_ppgGreen),
              ]),
              Row(children: [
                const Text('PPG Ambient: '),
                Text(_ppgAmbient),
              ]),
              Row(children: const [
                Text(
                    '\nNote: You have to insert the earbud in your  \n ear in order to receive heart rate values.')
              ]),
              Row(children: const [
                Text(
                    '\nNote: Accelerometer and PPG have unknown units. \n They were reverse engineered. \n Use with caution!')
              ]),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !_isConnected,
        child: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Increment',
          child: const Icon(Icons.bluetooth_searching_sharp),
        ),
      ),
    );
  }
}
