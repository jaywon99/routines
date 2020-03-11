import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  final String title = 'About';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        // TODO: changing to scrollable widget with padding
        // https://stackoverflow.com/questions/52053850/flutter-how-to-make-a-column-screen-scrollable
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'About information will be here.',
            ),
          ],
        ),
      ),
    );
  }
}
