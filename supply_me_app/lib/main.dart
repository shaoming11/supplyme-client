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
              spacing: 10,  
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Column(
                  spacing: 90,
                  children: [
                    Text(
                      "What do you want to look for?",
                      style: TextStyle(fontSize: 30)
                    ),
                    SearchAnchor(
                      builder: (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          hintText: 'Search for a company',
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                          leading: const Icon(Icons.search),
                        );
                      },
                      suggestionsBuilder: (BuildContext context, SearchController controller) {
                        return List<ListTile>.generate(5, (int index) {
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
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage())
                        );
                      }, 
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 141, 30, 192),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                      ),
                      child: const Text("Search", 
                      style: TextStyle(fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)))
                    )
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

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Second Page"),
      ),
     body: Center(
        child: ElevatedButton(
            child: Text("Go back"),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ),
    );
  }
}