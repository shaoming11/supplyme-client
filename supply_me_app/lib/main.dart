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
              spacing: 15,
              mainAxisSize: MainAxisSize.min,  
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

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _begin = AlwaysStoppedAnimation(Alignment.topLeft);
  late Animation<Alignment> _end = AlwaysStoppedAnimation(Alignment.bottomRight);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _begin = TweenSequence<Alignment>([
      TweenSequenceItem(tween: Tween(begin: Alignment.topLeft, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomLeft, end: Alignment.bottomRight), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomRight, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.topRight, end: Alignment.topLeft), weight: 1),
    ]).animate(_controller);

    _end = TweenSequence<Alignment>([
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight), weight: 1),
      TweenSequenceItem(tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight), weight: 1),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedBorderBox({required Widget child}) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          padding: const EdgeInsets.all(4), // border thickness
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: _begin.value,
              end: _end.value,
              colors: const [Color.fromARGB(255, 85, 2, 123), Color.fromARGB(255, 1, 146, 100)],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black, // solid color inside
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Results for "${widget.query}"')),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75, // 75% of screen height
            child: _buildAnimatedBorderBox(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'You searched for: ${widget.query}',
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    const SizedBox(height: 30),
                    ...List.generate(3, (i) => Container(
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 20),
                          height: 100,
                          width: double.infinity,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }   
}
