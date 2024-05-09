import 'package:flutter/foundation.dart'; // Assicurati di includere foundation.dart per kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timeware_test/data/controller/species_controller.dart';
import 'package:timeware_test/data/model/species_model.dart';

class SpecieDetailScreen extends StatefulWidget {
  final int specieId;
  final String specieName;

  const SpecieDetailScreen({super.key, required this.specieId, required this.specieName});

  @override
  State<SpecieDetailScreen> createState() => _SpecieDetailScreenState();
}

class _SpecieDetailScreenState extends State<SpecieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: kIsWeb ? 0.0 : 200.0,
            floating: false,
            pinned: true,
            backgroundColor: kIsWeb ? Theme.of(context).primaryColor : Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: kIsWeb
                ? FlexibleSpaceBar(
                    title: Text(widget.specieName, style: const TextStyle(color: Colors.white)),
                  )
                : FlexibleSpaceBar(
                    title: Text(widget.specieName, style: const TextStyle(color: Colors.white)),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/animal_image.png',
                          fit: BoxFit.cover,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent, Colors.black],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<SpeciesModel>(
              future: SpeciesController().fetchDetailSpeciesById(widget.specieId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: kIsWeb ? const EdgeInsets.all(24.0) : const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        buildDetailSection('Taxonomic Notes', snapshot.data!.taxonomicNotes),
                        buildDetailSection('Rationale for Assessment', snapshot.data!.rationale),
                        buildDetailSection('Geographic Range', snapshot.data!.geographicRange),
                        buildDetailSection('Population', snapshot.data!.population),
                        buildDetailSection('Population Trend', snapshot.data!.populationTrend),
                        buildDetailSection('Habitat and Ecology', snapshot.data!.habitat),
                        buildDetailSection('Threats', snapshot.data!.threats),
                        buildDetailSection('Conservation Measures', snapshot.data!.conservationMeasures),
                        buildLastDetailSection('Use and Trade', snapshot.data!.useTrade),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Map<String, IconData> iconMapping = {
    'Taxonomic Notes': Icons.book,
    'Rationale for Assessment': Icons.account_balance,
    'Geographic Range': Icons.map,
    'Population': Icons.group,
    'Population Trend': Icons.trending_up,
    'Habitat and Ecology': Icons.eco,
    'Threats': Icons.warning_amber,
    'Conservation Measures': Icons.shield,
    'Use and Trade': Icons.shopping_cart,
  };

  Map<String, Color> colorMapping = {
    'Taxonomic Notes': Colors.brown,
    'Rationale for Assessment': Colors.orange,
    'Geographic Range': Colors.brown,
    'Population': Colors.green,
    'Population Trend': Colors.orange,
    'Habitat and Ecology': Colors.green,
    'Threats': Colors.orange,
    'Conservation Measures': Colors.brown,
    'Use and Trade': Colors.brown,
  };

  Widget buildDetailSection(String title, String? content) {
    IconData icon = iconMapping[title] ?? Icons.help_outline;
    Color iconColor = colorMapping[title] ?? Colors.grey;

    return Padding(
      padding: kIsWeb ? const EdgeInsets.all(28.0) : const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            ],
          ),
          Html(data: content ?? "No information provided"),
        ],
      ),
    );
  }

  Widget buildLastDetailSection(String title, String? content) {
    return Padding(
     padding: kIsWeb ? const EdgeInsets.all(24.0) : const EdgeInsets.all(16.0),
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
