import 'package:flutter/material.dart';
import 'package:platform_channels_dojo_example/platform_channels/PlatformChannel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _osVersion = 'Press the button to get the OS version';

  Future<void> _fetchOSVersion() async {
    PlatformChannel platformChannel = PlatformChannel();
    String result = await platformChannel.getOSVersion();
    setState(() {
      _osVersion = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_osVersion),
            ElevatedButton(
              onPressed: _fetchOSVersion,
              child: const Text('Get OS version'),
            ),
          ],
        ),
      ),
    );
  }
}