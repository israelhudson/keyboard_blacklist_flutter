import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platformNativeToFlutter = MethodChannel('native_to_flutter');
  static const platformFlutterToNative = MethodChannel('flutter_to_native');
  String _batteryLevel = 'Unknown battery level.';
  String isSucess = '-----';

  void callMethodChannel() async {
    String batteryLevel;
    try {
      final int result =
          await platformNativeToFlutter.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  void setMethodChannel() async {
    String _isSuccess = '-----';
    try {
      final int result =
          await platformFlutterToNative.invokeMethod('getBatteryLevel', '');
      _isSuccess = result.toString();
    } on PlatformException catch (e) {
      _isSuccess = e.message.toString();
    } on Exception catch (e) {
      _isSuccess = e.toString();
    }

    setState(() {
      isSucess = _isSuccess;
    });
  }

  @override
  void initState() {
    callMethodChannel();
    //setMethodChannel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_batteryLevel',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '$isSucess',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setMethodChannel(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
