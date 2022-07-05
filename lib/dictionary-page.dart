import 'dart:async';
import 'dart:developer';

import 'package:dictionaryapp/services/api.dart';
import 'package:dictionaryapp/utils/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  TextEditingController wordController = TextEditingController();
  late StreamController<dynamic> streamController;
  late Stream<dynamic> stream;

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    stream = streamController.stream;
  }

  search() async {
    if (wordController.text.isEmpty) {
      streamController.add(null);
    } else {
      streamController.add("waiting");
      var dictionary = await getDictionary(wordController.text.trim());

      if (dictionary == null) {
        streamController.add(null);
      }

      streamController.add(dictionary);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD WIDGET");
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dictionary",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          backgroundColor: appBarColor,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 20.0, left: 15, bottom: 5),
                      child: TextFormField(
                        onChanged: (value) {
                          search();
                        },
                        controller: wordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: accentColor,
                          hintText: 'Search for word',
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.75)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 20.0),
                          border: const OutlineInputBorder(
                            //  borderSide: BorderSide(color: primaryColor, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await search();
                      },
                      icon: const Icon(
                        CupertinoIcons.search,
                        color: Colors.white,
                      ))
                ],
              )),
        ),
        body: StreamBuilder<dynamic>(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                    child: Text(
                  "Enter your word",
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ));
              } else if (snapshot.data == "waiting") {
                return const Center(child: CircularProgressIndicator());
              } else {
                var dictionaryModel = snapshot.data;
                log(dictionaryModel["definitions"].length.toString());
                return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: dictionaryModel["definitions"].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: (dictionaryModel["definitions"].length == 1)
                            ? BoxDecoration(
                                boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 206, 206, 206),
                                        blurRadius: 6,
                                        spreadRadius: 3)
                                  ],
                                color: const Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(20))
                            : const BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                child: Container(
                                  height: getDeviceWidth(context) / 10,
                                  width: getDeviceWidth(context) / 2,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 195, 195, 195),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "${dictionaryModel["word"]}",
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Flexible(
                                        child: Text(
                                          " (${dictionaryModel["definitions"][index]["type"]})",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Pronounce: ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: typeColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // Text(
                                    //   dictionaryModel["pronunciation"] ?? "",
                                    //   style: const TextStyle(
                                    //       fontSize: 18,
                                    //       color: Color.fromARGB(
                                    //           255, 138, 138, 138),
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "Definition: ${dictionaryModel["definitions"][index]["definition"] ?? " "}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  //  color: wordColor,
                                ),
                              ),
                              subtitle: Text(
                                "Example: ${dictionaryModel["definitions"][index]["example"] ?? " "}",
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            //: Container(),
                            SizedBox(
                              width: getDeviceWidth(context) * 0.9,
                              child: const Divider(
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
            }));
  }
}
