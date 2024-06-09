import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search and Timeline App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  List<String> _userSuggestions = [
    'User 1',
    'User 2',
    'User 3',
    'User 4',
    'User 5'
  ];
  String? _selectedUser;
  List<String> _filteredSuggestions = [];
  int _selectedSuggestionIndex = -1; // To keep track of the selected suggestion
  Map<String, List<Map<String, String>>> _userEvents = {
    'User 1': [
      {
        'title': 'Event 1',
        'description': 'Description for Event 1',
        'timestamp': '2024-05-01 10:00'
      },
      {
        'title': 'Event 2',
        'description': 'Description for Event 2',
        'timestamp': '2024-05-02 12:00'
      },
      {
        'title': 'Event 3',
        'description': 'Description for Event 3',
        'timestamp': '2024-05-03 14:00'
      },
    ],
    'User 2': [
      {
        'title': 'Event 4',
        'description': 'Description for Event 4',
        'timestamp': '2024-05-04 16:00'
      },
      {
        'title': 'Event 5',
        'description': 'Description for Event 5',
        'timestamp': '2024-05-05 18:00'
      },
      {
        'title': 'Event 6',
        'description': 'Description for Event 6',
        'timestamp': '2024-05-06 20:00'
      },
      {
        'title': 'Event 7',
        'description': 'Description for Event 7',
        'timestamp': '2024-05-07 22:00'
      },
    ],
    'User 3': [
      {
        'title': 'Event 8',
        'description': 'Description for Event 8',
        'timestamp': '2024-05-08 09:00'
      },
      {
        'title': 'Event 9',
        'description': 'Description for Event 9',
        'timestamp': '2024-05-09 11:00'
      },
    ],
    'User 4': [
      {
        'title': 'Event 10',
        'description': 'Description for Event 10',
        'timestamp': '2024-05-10 13:00'
      },
      {
        'title': 'Event 11',
        'description': 'Description for Event 11',
        'timestamp': '2024-05-11 15:00'
      },
    ],
    'User 5': [
      {
        'title': 'Event 12',
        'description': 'Description for Event 12',
        'timestamp': '2024-05-12 17:00'
      },
      {
        'title': 'Event 13',
        'description': 'Description for Event 13',
        'timestamp': '2024-05-13 19:00'
      },
      {
        'title': 'Event 14',
        'description': 'Description for Event 14',
        'timestamp': '2024-05-14 21:00'
      },
      {
        'title': 'Event 15',
        'description': 'Description for Event 15',
        'timestamp': '2024-05-15 23:00'
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _filteredSuggestions.clear();
          _selectedSuggestionIndex = -1;
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged(String text) {
    setState(() {
      if (text.isEmpty) {
        _filteredSuggestions.clear();
      } else {
        _filteredSuggestions = _userSuggestions
            .where((suggestion) =>
                suggestion.toLowerCase().contains(text.toLowerCase()))
            .toList();
        _selectedSuggestionIndex = -1; // Reset the selected index
      }
    });
  }

  void _onSuggestionTap(String suggestion) {
    setState(() {
      _searchController.text = suggestion;
      _selectedUser = suggestion;
      _filteredSuggestions.clear();
      _selectedSuggestionIndex = -1;
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        setState(() {
          _searchController.clear();
          _filteredSuggestions.clear();
          _selectedUser = null;
          _selectedSuggestionIndex = -1;
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (_selectedSuggestionIndex >= 0 &&
            _selectedSuggestionIndex < _filteredSuggestions.length) {
          _onSuggestionTap(_filteredSuggestions[_selectedSuggestionIndex]);
          return KeyEventResult.handled;
        }
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          if (_selectedSuggestionIndex < _filteredSuggestions.length - 1) {
            _selectedSuggestionIndex++;
          } else {
            _selectedSuggestionIndex = 0;
          }
        });
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          if (_selectedSuggestionIndex > 0) {
            _selectedSuggestionIndex--;
          } else {
            _selectedSuggestionIndex = _filteredSuggestions.length - 1;
          }
        });
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search and Timeline App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Focus(
                  focusNode: _focusNode,
                  onKeyEvent: _onKeyEvent,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Users',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _selectedUser = null;
                            _filteredSuggestions.clear();
                            _selectedSuggestionIndex = -1;
                          });
                        },
                      ),
                    ),
                    onChanged: _onTextChanged,
                  ),
                ),
                Expanded(
                  child: _selectedUser == null
                      ? Center(
                          child: Text('No user selected'),
                        )
                      : _userEvents[_selectedUser] != null
                          ? ListView.builder(
                              itemCount: _userEvents[_selectedUser]!.length,
                              itemBuilder: (context, index) {
                                return TimelineTile(
                                    event: _userEvents[_selectedUser]![index]);
                              },
                            )
                          : Center(
                              child:
                                  Text('No events found for the selected user'),
                            ),
                ),
              ],
            ),
            if (_filteredSuggestions.isNotEmpty)
              Positioned(
                left: 0,
                right: 0,
                top: 75, // Adjust this value to fit your layout
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredSuggestions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: _selectedSuggestionIndex == index
                            ? Colors.grey[300]
                            : Colors.white,
                        child: ListTile(
                          title: Text(_filteredSuggestions[index]),
                          onTap: () {
                            setState(() {
                              _onSuggestionTap(_filteredSuggestions[index]);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final Map<String, String> event;

  TimelineTile({required this.event});

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 2,
                height: 20,
                color: Colors.grey,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(width: 16),
          Text(event['timestamp']!, style: TextStyle(color: Colors.grey)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event['title']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (!isLargeScreen) Text(event['description']!),
              ],
            ),
          ),
          if (isLargeScreen)
            Flexible(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(event['description']!),
              ),
            ),
        ],
      ),
    );
  }
}
