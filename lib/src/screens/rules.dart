import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/providers/rules_provider.dart';

class Rules extends ConsumerWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rules = ref.watch(rulesProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Reglas"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: ListView.builder(
          padding: const EdgeInsets.only(bottom: 80.0),
          itemCount: rules.length,
          itemBuilder: (context, index) => CheckboxListTile(
            title: Text(rules[index].name),
            secondary: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset(rules[index].imagePath),
                              const SizedBox(height: 20),
                              Text(
                                rules[index].name,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                rules[index].description,
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.asset(rules[index].imagePath, width: 50, height: 50),
            ),
            value: rules[index].enabled,
            onChanged: (value) {
              ref.read(rulesProvider.notifier).toggleRule(index);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Hecho',
        child: const Icon(Icons.done),
      ),
    );
  }
}
