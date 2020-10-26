import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = Set(); // NEW
  double val;

  void initState() {
    super.initState();
    val = 0;
  }

  void change(prix) {
    setState(() {
      val += prix;
    });
  }

  void remove(prix) {
    setState(() {
      val -= prix;
    });
  }

  int _currentIndex = 0;
  bool check = false;
  // List _children = [_list(), _pushSaved()];

  void onTappedBar(int index) {
    setState(() {
      if (index == 0) {
        check = false;
      } else {
        check = true;
      }
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("List Page"),
        ),
        body: check ? _pushSaved() : _list(),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Color(0xFF6200EE),
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.white,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption: new TextStyle(
                      color: Colors.white.withOpacity(
                          .60)))), // sets the inactive color of the `BottomNavigationBar`
          child: new BottomNavigationBar(
            onTap: onTappedBar,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                title: new Text('List'),
                icon: new Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                title: Text('Card'),
                icon: new Icon(Icons.search_sharp),
              ),
            ],
          ),
        ));
  }

  Widget _buildSuggestions() {
    final _suggestions = ["coucou", "salut", "bienvenue"];
    final _prix = [15, 30, 8];
    int index = -1;

    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          //final index = i ~/ 2; /*3*/
          if (index < _suggestions.length - 1) {
            index++;
            return _buildRow(_suggestions[index], _prix[index]);
          }
        });
  }

  Widget _buildRow(pair, prix) {
    final alreadySaved = _saved.contains(prix);

    return ListTile(
      title: Text(
        pair + " " + prix.toString() + "€",
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // NEW lines from here...

        setState(() {
          if (alreadySaved) {
            remove(prix);
            _saved.remove(prix);
          } else {
            change(prix);

            _saved.add(prix);
          }
        });
      },
    );
  }

  Widget _pushSaved() {
    return Center(
      child: Text(
        "Total : " + val.toString(),
        style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _list() {
    return Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: _buildSuggestions(),
    );
  }
}
