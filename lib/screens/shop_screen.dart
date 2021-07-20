import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salla/screens/search_screen.dart';
import 'package:salla/statemanagement/shop_state.dart';

class ShopScreen extends StatelessWidget {
  static const String route = 'shop-screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopState>(
      builder: (ctx, Data, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Salla'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.route);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: Data.changeBottom,
          currentIndex: Data.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings ',
            ),
          ],
        ),
        body: Data.bottomScreens[Data.currentIndex],
      ),
    );
  }
}
