import 'dart:convert';
import 'package:timeware_test/data/model/species_model.dart';
import 'package:http/http.dart' as http;

class SpeciesController {
  String category = 'VU';
  String token = '9bb4facb6d23f48efbf424bb05c0c1ef1cf6f468393bc745d42179ac4aca5fee';

  static final SpeciesController _instance = SpeciesController._internal();

  SpeciesController._internal();

  factory SpeciesController() {
    return _instance;
  }

  List<SpeciesModel> _speciesList = [];

  Map<String, List<SpeciesModel>> mapSpeciesListByFirstLetter = {};

  Future<List<SpeciesModel>> fetchSpeciesByCategory() async {
    final url = 'https://apiv3.iucnredlist.org/api/v3/species/category/$category?token=$token';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = json.decode(response.body)['result'];
      _speciesList = List.from(result).map((e) => SpeciesModel.fromJson(e)).toList();
      mapSpeciesListByFirstLetter = _groupByFirstLetter(_speciesList);

      return _speciesList;
    } else {
      throw Exception('Failed to load species');
    }
  }

  Future<SpeciesModel> fetchDetailSpeciesById(int specieId) async {
    final url = 'https://apiv3.iucnredlist.org/api/v3/species/narrative/id/$specieId?token=$token';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && json.decode(response.body)['result'].isNotEmpty) {
      var result = json.decode(response.body)['result'][0];
      return SpeciesModel.fromNarrativeJson(result);
    } else {
      throw Exception('Empty specie details');
    }
  }

  Map<String, List<SpeciesModel>> _groupByFirstLetter(List<SpeciesModel> results) {
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
