import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeware_test/data/model/species_model.dart';

class SpeciesListScreen extends StatefulWidget {
  final List<SpeciesModel> speciesList;
  final String letter;

  const SpeciesListScreen({super.key, required this.speciesList, required this.letter});

  @override
  State<SpeciesListScreen> createState() => _SpeciesListScreenState();
}

class _SpeciesListScreenState extends State<SpeciesListScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Species starting with ${widget.letter}'),
        ),
        body: Scrollbar(
            controller: controller,
            thumbVisibility: true,
            thickness: 8.0,
            radius: const Radius.circular(5),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
              child: ListView.builder(
                controller: controller,
                itemCount: widget.speciesList.length,
                itemBuilder: (context, index) {
                  var species = widget.speciesList[index];

                  return ListTile(
                    onTap: () {
                      navigateToDetailSpecie(species.scientificName!, {'specieId': species.taxonid!});
                    },
                    title: Text(species.scientificName ?? 'No Name'),
                    //subtitle: Text(species.rank),
                  );
                },
              ),
            )));
  }

  void navigateToDetailSpecie(String name, Map extra) {
    GoRouter.of(context).go('/detail/$name', extra: extra);
  }
}
