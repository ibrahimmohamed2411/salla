import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const String route = 'search-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Text(
          'Search Screen',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
