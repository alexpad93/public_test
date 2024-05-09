import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vulnerable Species List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Container(
            color: Colors.brown.shade400,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'Select a letter order to alphabetically find species',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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

            return Scrollbar(
                controller: controller,
                thumbVisibility: true,
                thickness: 8.0,
                radius: const Radius.circular(5),
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
                    child: ListView.separated(
                      controller: controller,
                      itemCount: alphabet.length,
                      itemBuilder: (context, index) {
                        String key = alphabet[index];

                        return Column(
                          children: [
                            ListTile(
                              contentPadding: kIsWeb ? const EdgeInsets.all(24.0) : const EdgeInsets.all(16.0),
                              title: Center(
                                  child: Text(
                                key,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              )),
                              onTap: () => navigateToSpecies(key),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                    )));
          }
        },
      ),
    );
  }

  void navigateToSpecies(String letter) {
    GoRouter.of(context).go('/species/$letter');
  }
}
