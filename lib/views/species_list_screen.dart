import 'package:flutter/material.dart';
import 'package:timeware_test/data/controller/species_controller.dart';
import 'package:timeware_test/data/model/species_model.dart';

class SpeciesListScreen extends StatelessWidget {
  const SpeciesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Species List'),
      ),
      body: FutureBuilder<List<SpeciesModel>>(
        future: SpeciesController().fetchSpeciesByCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, List<SpeciesModel>> groupedResults = SpeciesController().groupByFirstLetter(snapshot.data!);
            List<String> sortedKeys = groupedResults.keys.toList()..sort();

            return ListView.builder(
              itemCount: sortedKeys.length,
              itemBuilder: (context, index) {
                String key = sortedKeys[index];
                List<SpeciesModel> speciesList = groupedResults[key]!;

                return ExpansionTile(
                  title: Text(key),
                  children: speciesList
                      .map((species) => ListTile(
                            title: Text(species.scientificName ?? 'No Name'),
                            subtitle: const Text('Category: Vu'),
                          ))
                      .toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
