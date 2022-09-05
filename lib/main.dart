import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_blacklist_flutter/two_example.dart';

import 'example_platform_channels.dart';

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

  var examplePlatformChannel = ExamplePlatformChannel();

  String _result = '';

  String? nameRequest;

  @override
  void initState() {
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (val) => nameRequest = val,
                decoration: InputDecoration(hintText: 'Name'),
              ),
            ),
            Text(
              'Method Chaneel Result:',
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.headline4,
            ),
            FloatingActionButton(
              heroTag: 'hr1',
              onPressed: () async {
                _result =
                    await examplePlatformChannel.callSimpleMethodChannel();
                setState(() {});
              },
              tooltip: 'Call Method Channel',
              child: Text('1'),
            ),
            FloatingActionButton(
              heroTag: 'hr2',
              onPressed: () async {
                _result = await examplePlatformChannel
                    .callSimpleMethodChannelWithParams(nameRequest!);
                setState(() {});
              },
              tooltip: 'Call Method Channel with param',
              child: Text('2'),
            ),
            FloatingActionButton(
              heroTag: 'hr3',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TwoExamplePage()),
                );
              },
              tooltip: 'Go to Outher Example',
              child: Text('3'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
