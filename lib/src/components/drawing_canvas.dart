import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DrawingCanvas extends StatefulWidget {
  final Function(String base64Image) onImageCreated;

  const DrawingCanvas({super.key, required this.onImageCreated});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  List<Offset?> points = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  points.add(details.localPosition);
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  points.add(null);
                });
              },
              child: CustomPaint(
                size: const Size(300, 200),
                painter: DrawingPainter(points: points, color: selectedColor, strokeWidth: strokeWidth),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Selector de color
            Column(
              children: [
                const Text('Color', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: () => _showColorPicker(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: selectedColor,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            // Selector de grosor
            Column(
              children: [
                const Text('Grosor', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                Slider(
                  value: strokeWidth,
                  min: 1.0,
                  max: 10.0,
                  divisions: 9,
                  onChanged: (value) {
                    setState(() {
                      strokeWidth = value;
                    });
                  },
                ),
              ],
            ),
            // Botón limpiar
            Column(
              children: [
                const Text('Limpiar', style: TextStyle(fontSize: 12)),
                const SizedBox(height: 4),
                IconButton(
                  onPressed: () {
                    setState(() {
                      points.clear();
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: points.isNotEmpty ? _saveImage : null, child: const Text('Guardar Dibujo')),
      ],
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: selectedColor,
            onColorChanged: (color) {
              setState(() {
                selectedColor = color;
              });
            },
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Aceptar'))],
      ),
    );
  }

  void _saveImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..color = selectedColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Dibujar el fondo blanco
    canvas.drawRect(const Rect.fromLTWH(0, 0, 300, 200), Paint()..color = Colors.white);

    // Dibujar los puntos
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(300, 200);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    // Convertir a base64
    final base64String = base64Encode(bytes);
    widget.onImageCreated(base64String);
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  DrawingPainter({required this.points, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class ColorPicker extends StatefulWidget {
  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({super.key, required this.pickerColor, required this.onColorChanged});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.pickerColor;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GestureDetector(
              onPanUpdate: (details) => _updateColor(details.localPosition),
              onTapDown: (details) => _updateColor(details.localPosition),
              child: CustomPaint(
                painter: ColorPickerPainter(
                  selectedColor: _currentColor,
                  onColorChanged: (color) {
                    setState(() {
                      _currentColor = color;
                    });
                    widget.onColorChanged(color);
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildColorButton(Colors.red),
            _buildColorButton(Colors.orange),
            _buildColorButton(Colors.yellow),
            _buildColorButton(Colors.green),
            _buildColorButton(Colors.blue),
            _buildColorButton(Colors.purple),
            _buildColorButton(Colors.pink),
            _buildColorButton(Colors.black),
            _buildColorButton(Colors.white),
          ],
        ),
      ],
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentColor = color;
        });
        widget.onColorChanged(color);
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: _currentColor == color ? Colors.blue : Colors.grey, width: _currentColor == color ? 3 : 1),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  void _updateColor(Offset position) {
    // Implementación simple de selector de color
    // En una implementación real, esto calcularía el color basado en la posición
    final colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple, Colors.pink, Colors.black, Colors.white];

    final index = ((position.dx / 200) * colors.length).floor();
    if (index >= 0 && index < colors.length) {
      setState(() {
        _currentColor = colors[index];
      });
      widget.onColorChanged(_currentColor);
    }
  }
}

class ColorPickerPainter extends CustomPainter {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  ColorPickerPainter({required this.selectedColor, required this.onColorChanged});

  @override
  void paint(Canvas canvas, Size size) {
    // Crear un gradiente de colores
    final paint = Paint();

    // Gradiente simple de colores
    final colors = [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple];

    for (int i = 0; i < colors.length; i++) {
      final colorRect = Rect.fromLTWH((size.width / colors.length) * i, 0, size.width / colors.length, size.height);
      paint.color = colors[i];
      canvas.drawRect(colorRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
