import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeware_test/data/controller/species_controller.dart';
import 'package:timeware_test/data/model/species_model.dart';

class SpeciesListScreen extends StatefulWidget {
  final String letter;

  const SpeciesListScreen({super.key, required this.letter});

  @override
  State<SpeciesListScreen> createState() => _SpeciesListScreenState();
}

class _SpeciesListScreenState extends State<SpeciesListScreen> {
  List<SpeciesModel>? speciesListOrderByLetter;

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    speciesListOrderByLetter = SpeciesController().mapSpeciesListByFirstLetter[widget.letter];

    return Scaffold(
        appBar: AppBar(
          title: Text('Species starting with ${widget.letter}'),
        ),
        body: speciesListOrderByLetter == null || speciesListOrderByLetter!.isEmpty
            ? const Center(
                child: Text('No species list found for this letter'),
              )
            : Scrollbar(
                controller: controller,
                thumbVisibility: true,
                thickness: 8.0,
                radius: const Radius.circular(5),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 0.5,
                      endIndent: 0.5,
                    ),
                    controller: controller,
                    itemCount: speciesListOrderByLetter!.length,
                    itemBuilder: (context, index) {
                      var species = speciesListOrderByLetter![index];
                      return ListTile(
                        contentPadding:  kIsWeb ? const EdgeInsets.all(24.0) : const EdgeInsets.all(16.0),
                        trailing: const Icon(Icons.arrow_right),
                        onTap: () {
                          navigateToDetailSpecie(species.taxonid!, {'specieName': species.scientificName!});
                        },
                        title: Text(
                          species.scientificName ?? 'No Name',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  ),
                ),
              ));
  }

  void navigateToDetailSpecie(int specieId, Map<String, String> extra) {
    GoRouter.of(context).go('/detail/$specieId', extra: extra);
  }
}
