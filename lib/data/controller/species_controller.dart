import 'dart:convert';

import 'package:timeware_test/data/model/species_model.dart';
import 'package:http/http.dart';

class SpeciesController {
  String category = 'VU';
  String token = '9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee';

  Future<List<SpeciesModel>> fetchSpeciesByCategory() async {
    final url = 'https://apiv3.iucnredlist.org/api/v3/species/category/$category?token=$token';
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = json.decode(response.body)['result'];
      return List.from(result).map((e) => SpeciesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load species');
    }
  }

  Map<String, List<SpeciesModel>> groupByFirstLetter(List<SpeciesModel> results) {
    Map<String, List<SpeciesModel>> groupedMap = {};
    for (var result in results) {
      String? name = result.scientificName;
      if (name != null && name.isNotEmpty) {
        String firstLetter = name[0].toUpperCase();

        if (!groupedMap.containsKey(firstLetter)) {
          groupedMap[firstLetter] = [];
        }

        groupedMap[firstLetter]!.add(result);
      }
    }
    return groupedMap;
  }
}
