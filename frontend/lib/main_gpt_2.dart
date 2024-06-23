import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreenGpt(),
    );
  }
}

class HomeScreenGpt extends StatefulWidget {
  @override
  _HomeScreenGptState createState() => _HomeScreenGptState();
}

class _HomeScreenGptState extends State<HomeScreenGpt> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _showResults = false;
  bool _showBio = false;
  String _selectedBio = '';
  List<String> _searchSuggestions = [];
  List<Map<String, dynamic>> _searchResults = [];
  FocusNode _searchFocusNode = FocusNode();
  int _selectedSuggestionIndex = -1;
  int _escapePressCount = 0;

  final List<Map<String, dynamic>> _objects = [
    {
      'object_id': {
        'id': 1,
        'name': 'Hemingway',
        'birth_date': '1899-07-21',
      },
      'bio': 'An influential writer known for his distinctive style and profound themes.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Won a Nobel Prize in Literature.',
          'description':
              'An influential writer with a distinctive style and profound themes, exploring human nature and societal issues in a way that has captivated readers for generations.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Lived in Paris for many years.',
          'description':
              'A master of storytelling with a deep understanding of human nature, whose works continue to be celebrated for their rich character development and intricate plots.',
          'isColourFlag': false,
        },
      ],
    },
    {
      'object_id': {
        'id': 2,
        'name': 'Fitzgerald',
        'birth_date': '1896-09-24',
      },
      'bio': 'A master of storytelling with a deep understanding of human nature.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Served in the Spanish Civil War.',
          'description':
              'Known for his dystopian vision and critical essays, providing a thought-provoking commentary on political and social structures.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Wrote about social injustice.',
          'description':
              'A classic novelist with intricate plots and memorable characters, delving into the complexities of human experience and social justice.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-08',
          'group_name': 'Explored themes of morality and society.',
          'description': 'A pioneer of romantic fiction and social commentary, whose works remain relevant and widely read to this day.',
          'isColourFlag': true,
        },
      ],
    },
    {
      'object_id': {
        'id': 3,
        'name': 'Orwell',
        'birth_date': '1903-06-25',
      },
      'bio': 'Known for his dystopian vision and critical essays.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Critiqued political structures.',
          'description':
              'An influential writer with a distinctive style and profound themes, exploring human nature and societal issues in a way that has captivated readers for generations.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Explored themes of totalitarianism.',
          'description':
              'A master of storytelling with a deep understanding of human nature, whose works continue to be celebrated for their rich character development and intricate plots.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-08',
          'group_name': 'Wrote about social justice.',
          'description':
              'Known for his dystopian vision and critical essays, providing a thought-provoking commentary on political and social structures.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-07',
          'group_name': 'Served in the Spanish Civil War.',
          'description':
              'A classic novelist with intricate plots and memorable characters, delving into the complexities of human experience and social justice.',
          'isColourFlag': false,
        },
      ],
    },
    {
      'object_id': {
        'id': 4,
        'name': 'Dickens',
        'birth_date': '1812-02-07',
      },
      'bio': 'A classic novelist with intricate plots and memorable characters.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Wrote about social injustice.',
          'description': 'A pioneer of romantic fiction and social commentary, whose works remain relevant and widely read to this day.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Explored themes of morality.',
          'description':
              'An iconic playwright and poet with timeless works that have shaped the literary canon and influenced countless writers and artists.',
          'isColourFlag': false,
        },
      ],
    },
    {
      'object_id': {
        'id': 5,
        'name': 'Austen',
        'birth_date': '1775-12-16',
      },
      'bio': 'A pioneer of romantic fiction and social commentary.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Critiqued social norms.',
          'description':
              'An influential writer with a distinctive style and profound themes, exploring human nature and societal issues in a way that has captivated readers for generations.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Wrote about love and society.',
          'description':
              'A master of storytelling with a deep understanding of human nature, whose works continue to be celebrated for their rich character development and intricate plots.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-08',
          'group_name': 'Explored themes of morality and society.',
          'description':
              'Known for his dystopian vision and critical essays, providing a thought-provoking commentary on political and social structures.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-07',
          'group_name': 'Critiqued social structures.',
          'description':
              'A classic novelist with intricate plots and memorable characters, delving into the complexities of human experience and social justice.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-06',
          'group_name': 'Wrote about the roles of women.',
          'description': 'A pioneer of romantic fiction and social commentary, whose works remain relevant and widely read to this day.',
          'isColourFlag': true,
        },
      ],
    },
    {
      'object_id': {
        'id': 6,
        'name': 'Shakespeare',
        'birth_date': '1564-04-23',
      },
      'bio': 'An iconic playwright and poet with timeless works.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Created timeless characters.',
          'description':
              'An iconic playwright and poet with timeless works that have shaped the literary canon and influenced countless writers and artists.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Wrote about human nature.',
          'description':
              'An influential writer with a distinctive style and profound themes, exploring human nature and societal issues in a way that has captivated readers for generations.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-08',
          'group_name': 'Explored themes of love and betrayal.',
          'description':
              'A master of storytelling with a deep understanding of human nature, whose works continue to be celebrated for their rich character development and intricate plots.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-07',
          'group_name': 'Wrote about political intrigue.',
          'description':
              'Known for his dystopian vision and critical essays, providing a thought-provoking commentary on political and social structures.',
          'isColourFlag': false,
        },
      ],
    },
    {
      'object_id': {
        'id': 7,
        'name': 'Tolstoy',
        'birth_date': '1828-09-09',
      },
      'bio': 'A Russian writer who is regarded as one of the greatest authors of all time.',
      'groups': [
        {
          'timestamp': '2023-06-10',
          'group_name': 'Explored themes of war and peace.',
          'description':
              'An influential writer with a distinctive style and profound themes, exploring human nature and societal issues in a way that has captivated readers for generations.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-09',
          'group_name': 'Wrote about the human condition.',
          'description':
              'A master of storytelling with a deep understanding of human nature, whose works continue to be celebrated for their rich character development and intricate plots.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-08',
          'group_name': 'Explored themes of love and family.',
          'description':
              'Known for his dystopian vision and critical essays, providing a thought-provoking commentary on political and social structures.',
          'isColourFlag': true,
        },
        {
          'timestamp': '2023-06-07',
          'group_name': 'Critiqued societal norms.',
          'description':
              'A classic novelist with intricate plots and memorable characters, delving into the complexities of human experience and social justice.',
          'isColourFlag': false,
        },
        {
          'timestamp': '2023-06-06',
          'group_name': 'Wrote about moral philosophy.',
          'description': 'A pioneer of romantic fiction and social commentary, whose works remain relevant and widely read to this day.',
          'isColourFlag': true,
        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _isSearching) {
        setState(() {
          _isSearching = false;
        });
      }
    });
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
        _searchSuggestions = _objects
            .where((obj) =>
                (obj['object_id']['name'] as String).toLowerCase().contains(query) ||
                (obj['object_id']['birth_date'] as String).toLowerCase().contains(query))
            .map<String>((obj) => '${obj['object_id']['name']} ${obj['object_id']['birth_date']}')
            .toList();
      });
    } else {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _onSearchSubmitted(String value) {
    setState(() {
      _isSearching = false;
      _showResults = true;
      _showBio = true;
      var selectedObject = _objects.firstWhere((obj) => '${obj['object_id']['name']} ${obj['object_id']['birth_date']}' == value);
      _selectedBio = selectedObject['bio'];
      _searchResults = selectedObject['groups'];
    });
  }

  void _handleKey(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.escape) {
        _escapePressCount++;
        if (_escapePressCount == 2) {
          setState(() {
            _searchController.clear();
            _showResults = false;
            _showBio = false;
            _searchSuggestions.clear();
            _escapePressCount = 0;
          });
        } else {
          setState(() {
            _isSearching = false;
          });
        }
      } else {
        _escapePressCount = 0;
      }

      if (event.logicalKey == LogicalKeyboardKey.arrowDown && _isSearching) {
        setState(() {
          _selectedSuggestionIndex = (_selectedSuggestionIndex + 1) % _searchSuggestions.length;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp && _isSearching) {
        setState(() {
          _selectedSuggestionIndex = (_selectedSuggestionIndex - 1 + _searchSuggestions.length) % _searchSuggestions.length;
        });
      } else if (event.logicalKey == LogicalKeyboardKey.enter && _isSearching) {
        if (_selectedSuggestionIndex >= 0 && _selectedSuggestionIndex < _searchSuggestions.length) {
          _searchController.text = _searchSuggestions[_selectedSuggestionIndex];
          _onSearchSubmitted(_searchSuggestions[_selectedSuggestionIndex]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: _handleKey,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    suffixIcon: _isSearching
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _isSearching = false;
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isSearching = value.isNotEmpty;
                      _showResults = false;
                    });
                  },
                  onSubmitted: _onSearchSubmitted,
                ),
              ),
              if (!_isSearching && !_showResults) _buildDefaultDescription(),
              if (_isSearching) _buildSearchSuggestions(),
              if (_showBio) _buildBio(),
              if (_showResults) Expanded(child: _buildSearchResults()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultDescription() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('Default description'),
    );
  }

  Widget _buildSearchSuggestions() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchSuggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _searchSuggestions[index],
              style: TextStyle(
                backgroundColor: _selectedSuggestionIndex == index ? Colors.grey[300] : null,
              ),
            ),
            onTap: () {
              _searchController.text = _searchSuggestions[index];
              _onSearchSubmitted(_searchSuggestions[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(_selectedBio),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return SearchResultItem(
          timestamp: _searchResults[index]['timestamp'],
          groupName: _searchResults[index]['group_name'],
          colorFlag: _searchResults[index]['isColourFlag'],
          description: _searchResults[index]['description'],
          onCollapseOthers: _collapseOthers,
        );
      },
    );
  }

  void _collapseOthers() {
    setState(() {
      _showResults = false;
      _showResults = true;
    });
  }
}

class SearchResultItem extends StatefulWidget {
  final String timestamp;
  final String groupName;
  final bool colorFlag;
  final String description;
  final VoidCallback onCollapseOthers;

  SearchResultItem({
    required this.timestamp,
    required this.groupName,
    required this.colorFlag,
    required this.description,
    required this.onCollapseOthers,
  });

  @override
  _SearchResultItemState createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.colorFlag ? Colors.green.shade100 : Colors.red.shade100,
      child: InkWell(
        onTap: () {
          widget.onCollapseOthers();
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(widget.timestamp),
                  SizedBox(width: 8.0),
                  Text(widget.groupName),
                ],
              ),
              if (_isExpanded) ...[
                SizedBox(height: 8.0),
                Text(widget.description),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
