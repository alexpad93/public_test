import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';  
import 'package:timeware_test/data/controller/species_controller.dart';
import 'package:timeware_test/data/model/species_model.dart';

class SpecieDetailScreen extends StatefulWidget {
  final int specieId;

  const SpecieDetailScreen({
    super.key,
    required this.specieId,
  });

  @override
  State<SpecieDetailScreen> createState() => _SpecieDetailScreenState();
}

class _SpecieDetailScreenState extends State<SpecieDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Species Details'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<SpeciesModel>(
        future: SpeciesController().fetchDetailSpeciesById(widget.specieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildDetailSection('Taxonomic Notes', snapshot.data!.taxonomicNotes),
                    buildDetailSection('Rationale for Assessment', snapshot.data!.rationale),
                    buildDetailSection('Geographic Range', snapshot.data!.geographicRange),
                    buildDetailSection('Population', snapshot.data!.population),
                    buildDetailSection('Population Trend', snapshot.data!.populationTrend),
                    buildDetailSection('Habitat and Ecology', snapshot.data!.habitat),
                    buildDetailSection('Threats', snapshot.data!.threats),
                    buildDetailSection('Conservation Measures', snapshot.data!.conservationMeasures),
                    buildDetailSection('Use and Trade', snapshot.data!.useTrade),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget buildDetailSection(String title, String? content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Html(data: content ?? "No information provided"),
        ],
      ),
    );
  }
}
