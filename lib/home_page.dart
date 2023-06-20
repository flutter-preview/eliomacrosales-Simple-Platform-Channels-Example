import 'package:flutter/material.dart';
import 'package:platform_channels_dojo_example/platform_channels/PlatformChannel.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            ElevatedButton(
              onPressed: () {
                PlatformChannel _ = PlatformChannel();
                _.getOSVersion();
              },
              child: const Text('Get OS version'),
            )
          ],
        ),
      ),
    );
  }
}
