// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'favorites_screen.dart';
import 'home_screen.dart';
import 'package:first_dart/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  print("Started");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'First App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // var current = WordPair.random();
  // var history = <WordPair>[];
  //
  // GlobalKey? historyListKey;
  //
  // void getNext() {
  //   history.insert(0, current);
  //   var animatedList = historyListKey?.currentState as AnimatedListState?;
  //   animatedList?.insertItem(0);
  //   current = WordPair.random();
  //   notifyListeners();
  // }
  //
  // var favorites = <WordPair>[];
  //
  // void toggleFavorite([WordPair? pair]) {
  //   pair = pair ?? current;
  //   if (favorites.contains(pair)) {
  //     favorites.remove(pair);
  //   } else {
  //     favorites.add(pair);
  //   }
  //   notifyListeners();
  // }
  //
  // void removeFavorite(WordPair pair) {
  //   favorites.remove(pair);
  //   notifyListeners();
  // }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = SearchScreen();
      case 1:
        page = FavoritesScreen();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Use a more mobile-friendly layout with BottomNavigationBar
            // on narrow screens.
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Search',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorites',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 800,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.search),
                        label: Text('Search'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
