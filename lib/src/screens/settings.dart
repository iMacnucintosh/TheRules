import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/providers/rules_provider.dart';
import 'package:therules/src/providers/shared_preferences_provider.dart';
import 'package:therules/src/providers/theme_provider.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late Color dialogPickerColor;

    dialogPickerColor = ref.watch(accentColorProvider);
    final sharedPreferences = ref.watch(sharedPreferencesProvider);

    Future<bool> colorPickerDialog() async {
      return ColorPicker(
        color: dialogPickerColor,
        onColorChanged: (Color color) {
          dialogPickerColor = color;

          sharedPreferences.setString("accent_color", color.toARGB32().toRadixString(16));
          ref.read(accentColorProvider.notifier).update((state) => color);
        },
        width: 40,
        height: 40,
        borderRadius: 4,
        spacing: 5,
        runSpacing: 5,
        wheelDiameter: 155,
        pickerTypeLabels: const {ColorPickerType.primary: "Primarios", ColorPickerType.accent: "Acento", ColorPickerType.wheel: "Selector"},
        pickerTypeTextStyle: Theme.of(context).textTheme.labelLarge,
        actionButtons: const ColorPickerActionButtons(dialogOkButtonLabel: "Aceptar", dialogCancelButtonLabel: "Cancelar"),
        heading: Text('Selecciona un Color', style: Theme.of(context).textTheme.titleMedium),
        subheading: Text('Puedes seleccionar una variante', style: Theme.of(context).textTheme.titleMedium),
        wheelSubheading: Text('Selecciona un color y su variante', style: Theme.of(context).textTheme.titleMedium),
        showMaterialName: true,
        showColorName: true,
        showColorCode: true,
        copyPasteBehavior: const ColorPickerCopyPasteBehavior(longPressMenu: true),
        materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
        colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
        colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
        colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
        selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: false,
          ColorPickerType.primary: true,
          ColorPickerType.accent: true,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
          ColorPickerType.wheel: true,
        },
      ).showPickerDialog(
        context,
        actionsPadding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
      );
    }

    final rules = ref.watch(rulesProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Configuración"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
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
                                    Text(rules[index].name, style: Theme.of(context).textTheme.headlineSmall),
                                    const SizedBox(height: 20),
                                    Text(rules[index].description, textAlign: TextAlign.justify),
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
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Modo Oscuro", style: TextStyle(fontSize: 16)),
                      Switch(
                        value: ref.watch(isDarkModeProvider),
                        onChanged: (value) {
                          sharedPreferences.setBool("is_dark_mode", value);
                          ref.read(isDarkModeProvider.notifier).update((state) => value);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    contentPadding: const EdgeInsets.only(right: 3),
                    title: const Text('Color de la aplicación'),
                    trailing: ColorIndicator(
                      width: 55,
                      height: 32,
                      borderRadius: 30,
                      color: dialogPickerColor,
                      onSelectFocus: false,
                      onSelect: () async {
                        final Color colorBeforeDialog = dialogPickerColor;
                        if (!(await colorPickerDialog())) {
                          dialogPickerColor = colorBeforeDialog;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Hecho',
        child: const Icon(Icons.done),
      ),
    );
  }
}
