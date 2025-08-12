import 'dart:convert';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/components/create_custom_rule_dialog.dart';
import 'package:therules/src/providers/custom_rules_provider.dart';
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
    final customRules = ref.watch(customRulesProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () async {
            final Color colorBeforeDialog = dialogPickerColor;
            if (!(await colorPickerDialog())) {
              dialogPickerColor = colorBeforeDialog;
            }
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: dialogPickerColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey, width: 1),
            ),
          ),
        ),
        title: const Text("Configuración"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(ref.watch(isDarkModeProvider) ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final newValue = !ref.read(isDarkModeProvider);
              sharedPreferences.setBool("is_dark_mode", newValue);
              ref.read(isDarkModeProvider.notifier).update((state) => newValue);
            },
            tooltip: ref.watch(isDarkModeProvider) ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro',
          ),
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
              child: ListView(
                children: [
                  // Sección de reglas predefinidas
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Reglas Predefinidas', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                  ),
                  ...List.generate(
                    rules.length,
                    (index) => CheckboxListTile(
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

                  const Divider(height: 32),

                  // Sección de reglas personalizadas
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mis Reglas', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog(context: context, builder: (context) => const CreateCustomRuleDialog());
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Crear'),
                        ),
                      ],
                    ),
                  ),
                  if (customRules.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'No tienes reglas personalizadas. ¡Crea tu primera regla!',
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                    )
                  else
                    ...List.generate(
                      customRules.length,
                      (index) => ListTile(
                        title: Text(customRules[index].name),
                        subtitle: Text(customRules[index].description, maxLines: 2, overflow: TextOverflow.ellipsis),
                        leading: GestureDetector(
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
                                          Container(
                                            width: 200,
                                            height: 150,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.memory(base64Decode(customRules[index].imageBase64), fit: BoxFit.cover),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(customRules[index].name, style: Theme.of(context).textTheme.headlineSmall),
                                          const SizedBox(height: 20),
                                          Text(customRules[index].description, textAlign: TextAlign.justify),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(base64Decode(customRules[index].imageBase64), fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: customRules[index].enabled,
                              onChanged: (value) {
                                ref.read(customRulesProvider.notifier).toggleCustomRule(customRules[index].id);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Eliminar Regla'),
                                    content: Text('¿Estás seguro de que quieres eliminar "${customRules[index].name}"?'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                                      TextButton(
                                        onPressed: () {
                                          ref.read(customRulesProvider.notifier).deleteCustomRule(customRules[index].id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
