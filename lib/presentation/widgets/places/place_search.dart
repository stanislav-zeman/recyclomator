import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/place.dart';
import 'package:recyclomator/infrastructure/services/places_service.dart';

class PlaceSearch extends StatefulWidget {
  PlaceSearch({super.key});

  final PlacesService _placesService = GetIt.I<PlacesService>();

  @override
  State<PlaceSearch> createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  final TextEditingController _controller = TextEditingController();
  List<Place> _places = [];

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
                hintText: 'Seek your location here',
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () => setState(() => _controller.clear()),
                ),
              ),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _places.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_places[index].formattedAddress),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  Future<void> _onChanged() async {
    final input = _controller.text;
    if (input == "") {
      return;
    }

    final places = await widget._placesService.getPlaceSuggestions(input);
    setState(() {
      _places = places;
    });
  }
}
