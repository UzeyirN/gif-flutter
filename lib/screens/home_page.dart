import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gif/styles/styles.dart';
import 'package:gif/widgets/gif_card.dart';
import 'package:http/http.dart' as http;

import '../consts/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var gifData;
  String gifTopic = 'punisher';
  TextEditingController textEditingController = TextEditingController();

  List<String> gifs = [];

  Future<void> getGifData() async {
    gifData = await http.get(
      Uri.parse(
          'https://tenor.googleapis.com/v2/search?q=$gifTopic&key=$key&client_key=my_test_app&limit=8'),
    );

    var gifDataParsed = jsonDecode(gifData.body);

    gifs.clear();

    setState(
      () {
        for (int i = 0; i < 5; ++i) {
          gifs.add(
              gifDataParsed['results'][i]['media_formats']['tinygif']['url']);
        }
      },
    );
  }

  @override
  void initState() {
    getGifData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return gifData == null
        ? Center(
            child: loading,
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Tenor GIF API',
                style: appBarTextStyle,
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        TextField(
                          controller: textEditingController,
                          onChanged: (newValue) {
                            gifTopic = newValue;
                          },
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                getGifData();
                              },
                            );
                            textEditingController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: Text(
                            'Get GIF',
                            style: buttonTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GifCard(gifs: gifs),
                ),
              ],
            ),
          );
  }

// SizedBox buildGifCard(BuildContext context) {
//   return SizedBox(
//     width: MediaQuery.of(context).size.width,
//     child: ListView.separated(
//       itemCount: gifs.length,
//       itemBuilder: (context, index) {
//         return Image.network(
//           gifs[index],
//           width: double.infinity,
//           fit: BoxFit.cover,
//         );
//       },
//       separatorBuilder: (context, index) {
//         return Divider(
//           height: 10,
//           color: Colors.transparent,
//         );
//       },
//     ),
//   );
// }
}
