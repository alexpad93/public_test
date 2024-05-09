import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timeware_test/data/controller/species_controller.dart';
import 'package:timeware_test/data/model/species_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final List<String> alphabet = List.generate(26, (index) => String.fromCharCode(index + 65));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vulnerable Species List'),
      ),
      body: FutureBuilder<List<SpeciesModel>>(
        future: SpeciesController().fetchSpeciesByCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final ScrollController controller = ScrollController();
            Map<String, List<SpeciesModel>> groupedResults = SpeciesController().groupByFirstLetter(snapshot.data!);

            return Scrollbar(
                controller: controller,
                thumbVisibility: true,
                thickness: 8.0,
                radius: const Radius.circular(5),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
                    child: ListView.builder(
                      controller: controller,
                      itemCount: alphabet.length,
                      itemBuilder: (context, index) {
                        String key = alphabet[index];
                        List<SpeciesModel> speciesList = groupedResults[key]!;

                        return ListTile(
                          title: Text(key),
                          onTap: () {
                            navigateToSpecies(key, {'letter': key, 'speciesList': speciesList});
                          },
                        );
                      },
                    )));
          }
        },
      ),
    );
  }

  void navigateToSpecies(String letter, Map extra) {
    GoRouter.of(context).go('/species/$letter', extra: extra);
  }
}
