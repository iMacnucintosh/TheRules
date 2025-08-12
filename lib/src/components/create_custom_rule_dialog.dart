import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:therules/src/components/drawing_canvas.dart';
import 'package:therules/src/providers/custom_rules_provider.dart';

class CreateCustomRuleDialog extends ConsumerStatefulWidget {
  const CreateCustomRuleDialog({super.key});

  @override
  ConsumerState<CreateCustomRuleDialog> createState() => _CreateCustomRuleDialogState();
}

class _CreateCustomRuleDialogState extends ConsumerState<CreateCustomRuleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedImageBase64;
  bool _isDrawing = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Crear Nueva Regla', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                      IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Campo Nombre
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la regla *',
                      border: OutlineInputBorder(),
                      hintText: 'Ej: La regla del silencio',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Campo Descripción
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción de la regla *',
                      border: OutlineInputBorder(),
                      hintText: 'Describe qué hace esta regla...',
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La descripción es obligatoria';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Sección de imagen
                  Text('Imagen de la regla *', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  if (_selectedImageBase64 != null) ...[
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(base64Decode(_selectedImageBase64!), fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _selectedImageBase64 = null;
                        });
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Eliminar imagen'),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _pickImageFromGallery,
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Galería'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _pickImageFromCamera,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Cámara'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('O dibuja tu propia imagen:'),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _isDrawing = !_isDrawing;
                        });
                      },
                      icon: Icon(_isDrawing ? Icons.close : Icons.brush),
                      label: Text(_isDrawing ? 'Cancelar dibujo' : 'Dibujar'),
                    ),
                  ],

                  if (_isDrawing && _selectedImageBase64 == null) ...[
                    const SizedBox(height: 16),
                    DrawingCanvas(
                      onImageCreated: (base64Image) {
                        setState(() {
                          _selectedImageBase64 = base64Image;
                          _isDrawing = false;
                        });
                      },
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Validación de imagen
                  if (_selectedImageBase64 == null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Debes seleccionar o dibujar una imagen para la regla', style: TextStyle(color: Colors.orange)),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Botones de acción
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _selectedImageBase64 != null ? _createRule : null,
                        child: _isLoading
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Crear Regla'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, maxWidth: 300, maxHeight: 200, imageQuality: 80);

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64String = base64Encode(bytes);
        setState(() {
          _selectedImageBase64 = base64String;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al seleccionar imagen: $e'), backgroundColor: Colors.red));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera, maxWidth: 300, maxHeight: 200, imageQuality: 80);

      if (image != null) {
        final bytes = await image.readAsBytes();
        final base64String = base64Encode(bytes);
        setState(() {
          _selectedImageBase64 = base64String;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al tomar foto: $e'), backgroundColor: Colors.red));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _createRule() {
    if (_formKey.currentState!.validate() && _selectedImageBase64 != null) {
      ref.read(customRulesProvider.notifier).addCustomRule(_nameController.text.trim(), _descriptionController.text.trim(), _selectedImageBase64!);

      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Regla personalizada creada exitosamente'), backgroundColor: Colors.green));
    }
  }
}
