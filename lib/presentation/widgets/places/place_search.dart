import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/place.dart';
import 'package:recyclomator/infrastructure/services/places_service.dart';

class PlaceSearch extends StatefulWidget {
  PlaceSearch({super.key, required this.onSelectPlace});

  final PlacesService _placesService = GetIt.I<PlacesService>();
  final ValueSetter<Place> onSelectPlace;

  @override
  State<PlaceSearch> createState() => _PlaceSearchState();
}

class _PlaceSearchState extends State<PlaceSearch> {
  final TextEditingController _controller = TextEditingController();
  List<Place> _places = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search for place',
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
        SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _places.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: TextButton(
                  child: Text(_places[index].formattedAddress),
                  onPressed: () {
                    widget.onSelectPlace(_places[index]);
                  },
                ),
              );
            },
          ),
        ),
      ],
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
