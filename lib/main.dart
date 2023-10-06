import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chrome_extension/devtools_panels.dart';
import 'package:chrome_extension/tabs.dart';
import 'package:flutter/material.dart';
import 'package:chrome_extension/runtime.dart';
import 'package:flutter_chrome_app/linkedin_user_model.dart';
import 'package:flutter_chrome_app/user_item.dart';
import 'package:flutter_chrome_app/user_parser.dart';
import 'package:html/parser.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
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
  bool isLoading = false;

  TextEditingController _textEditingController =
      TextEditingController(text: '');

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
        // appBar: AppBar(
        //   title: Text(widget.title),
        // ),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  huongdanSudungWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          itemBuilder: (c, i) {
                            return UserItem(
                              item: users[i],
                              stt: i + 1,
                              onTap: () {
                                setState(() {
                                  isLoading = true;
                                });

                                Future.delayed(const Duration(seconds: 2), () {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  var snackBar = const SnackBar(
                                    content: Text('UPDATED'),
                                    duration: Duration(milliseconds: 200),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBar,
                                  );
                                });
                              },
                            );
                          },
                          separatorBuilder: (c, i) {
                            return const Divider(
                              thickness: 2,
                              color: Colors.blueGrey,
                              height: 8,
                            );
                          },
                          itemCount: users.length),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: isLoading,
              child: const Positioned.fill(
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                    Text(
                      'CHECKING...',
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: false,
          child: FloatingActionButton(
            onPressed: () {
              _incrementCounter();
              // sendMessage(ParameterSendMessage(
              //     type: "counter", data: _counter.toString()));
            },
            tooltip: 'Increment',
            child: const Icon(Icons.abc),
          ),
        ));
  }

  Widget huongdanSudungWidget() {
    if (users.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'Enter keyword'),
            ),
            const Text("Recommend keywords:"),
            Wrap(
              children: [
                ...[
                  "Java",
                  "JavaScript",
                  "BlockChain",
                  "CTO",
                  "SEO",
                  "Freelancer",
                  "Junior",
                  "Huu hoang",
                  "mike codelight",
                  "BACKEND",
                  "FRONT END",
                  "Remote",
                  "HACKER"
                ].map((e) {
                  return InkWell(
                    onTap: () {
                      _textEditingController.text = e;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e),
                    ),
                  );
                }).toList(),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    var url =
                        'https://www.linkedin.com/search/results/people/?keywords=${_textEditingController.text}';
                    launchUrl(Uri.parse(url));
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.purple.shade100)),
                  child: const Text('Search'),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  void _fetchData() {
    chrome.tabs
        .query(QueryInfo(currentWindow: true, active: true))
        .then((value) {
      chrome.tabs.sendMessage(value[0].id!, "message", null).then((value) {
        var html = parse(value.toString());
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
