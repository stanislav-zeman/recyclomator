import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recyclomator/domain/entities/place.dart';
import 'package:recyclomator/infrastructure/services/models/places_suggestions_response.dart';

// ignore_for_file: avoid_dynamic_calls

class PlacesService {
  static const String _token = "AIzaSyB9iHgKBCKo5iHttDPO_ZcB6GXPabX-CFQ";

  Future<List<Place>> getPlaceSuggestions(String input) async {
    final Uri uri = Uri.https(
      "places.googleapis.com",
      "v1/places:searchText",
      {
        "fields": "*",
        "key": _token,
      },
    );

    final http.Response response = await http.post(
      uri,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode(<String, String>{
        "textQuery": input,
      }),
    );

    if (response.statusCode == 200) {
      final placesResponse = PlacesSuggestionsResponse.fromJson((jsonDecode(response.body) as Map).cast());
      return placesResponse.places;
    } else {
      throw Exception('Failed to load places');
    }
  }
}
