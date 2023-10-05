
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:flutter/material.dart';
import 'package:chrome_extension/runtime.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/user_parser.dart';
import 'package:html/parser.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _vlc = "VLC";

  List<LinkedinUserModel> users = [];

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });

    var currentTabid = (await chrome.tabs
            .query(QueryInfo(currentWindow: true, active: true)))[0]
        .id;
    setState(() {
      _vlc = 'currentTabid ${currentTabid}';
    });

    chrome.runtime
        .sendMessage(null, {"type": "counter", "data": _counter}, null)
        .then((value) {
      setState(() {
        _vlc = "OK ON ${value.runtimeType}";
      });
    }).catchError((onError) {
      setState(() {
        _vlc = "Errror on ${onError.runtimeType}";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (c, i) {
                    return const Divider(
                      thickness: 1,
                      height: 5,
                      color: Colors.red,
                    );
                  },
                  itemBuilder: (c, i) {
                    var item = users[i];
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: CachedNetworkImage(
                            imageUrl: item.avatar,
                            height: 96.0,
                            width: 96.0,
                            fit: BoxFit.cover,
                            placeholder: (
                              BuildContext context,
                              String url,
                            ) {
                              return const Icon(Icons.person);
                            },
                          ),
                        ),
                        Text('${item.name}'),
                        Text('${item.url}'),
                      ],
                    );
                  },
                  itemCount: users.length,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _incrementCounter();
            // sendMessage(ParameterSendMessage(
            //     type: "counter", data: _counter.toString()));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.abc),
        ));
  }

  void _fetchData() {
    chrome.tabs
        .query(QueryInfo(currentWindow: true, active: true))
        .then((value) {
      chrome.tabs.sendMessage(value[0].id!, "message", null).then((value) {
        var html = parse('${value.toString()}');
        setState(() {
          users = UserParser.bem(value.toString());
        });
      }).catchError((onError) {
        setState(() {
          _vlc = "\nSEND ERRPR: ${onError.toString()}";
        });
      });
    });
  }
}
