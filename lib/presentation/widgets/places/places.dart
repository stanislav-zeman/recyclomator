import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Places extends StatefulWidget {
  const Places({super.key});

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  final _controller = TextEditingController();
  String? _sessionToken;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = Uuid().v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    var uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {
        "input": input,
        "key": "AIzaSyB9iHgKBCKo5iHttDPO_ZcB6GXPabX-CFQ",
        "sessiontoken": _sessionToken,
      },
    );
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Seek your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel), onPressed: () => setState(() => _controller.clear()),
                ),
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _placeList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_placeList[index]["description"]),
              );
            },
          )
        ],
      ),
    );
  }
}
