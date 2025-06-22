import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/*ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blue,
    titleTextStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 18),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
  ),
);*/
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(1, 13,17,22),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 101, 24, 153),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
);


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  int index = 0;
  final SearchController _searchController = SearchController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: Scaffold(
        /*appBar: AppBar(
          automaticallyImplyLeading: false, 
          title: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: () {}, child: const Text("Features", style: TextStyle(fontSize: 20.0))),
                TextButton(onPressed: () {}, child: const Text("Pricing", style: TextStyle(fontSize: 20.0))),
                TextButton(onPressed: () {}, child: const Text("Support", style: TextStyle(fontSize: 20.0))),
              ],
            ),
          ),
        ),*/
       
        body: Center(
          child: Container(
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 15,  
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  spacing: 110,
                  children: [
                    Text(
                      "What do you want to look for?",
                      style: TextStyle(fontSize: 45)
                    ),
                    SearchAnchor(
                      searchController: _searchController, 
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          hintText: 'Search for a company',
                          onSubmitted: (value) => _handleSearch(context, value),
                          onTap: controller.openView,
                          onChanged: (_) => controller.openView(),
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller) {
                        return List<ListTile>.generate(8, (int index) {
                          final String item = 'item $index';
                          return ListTile (
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                controller.closeView(item);
                              });
                            },
                          );
                        });
                      },
                    ),
                    Builder(
                      builder: (context) {
                        return TextButton(
                          onPressed: () {
                            _handleSearch(context, _searchController.text);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 141, 30, 192),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            "Search",
                            style: TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



void _handleSearch(BuildContext context, String query) {
  final trimmed = query.trim();
  if (trimmed.isNotEmpty) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(query: trimmed),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results for "$query"')),
      body: Center(
        child: Text('You searched for: $query'),
      ),
    );
  }
}
