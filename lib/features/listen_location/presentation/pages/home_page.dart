import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel Example'),
      ),
      body: Center(
        child: Consumer<HomeProvider>(
          builder: (context, homeProvider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  '(${homeProvider.latitude} ; ${homeProvider.longitude})',
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(homeProvider.listeningLocation){
                      await homeProvider.stoptLocation();
                    }
                    else{
                      await homeProvider.startLocation();
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: homeProvider.listeningLocation ? Colors.red[400] : Colors.green[400],
                  ),
                  child: homeProvider.listeningLocation ? const Icon(Icons.stop_rounded) : const Icon(Icons.play_arrow),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}
