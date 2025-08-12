import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  DrawingStroke({required this.points, required this.color, required this.strokeWidth});
}

class DrawingCanvas extends StatefulWidget {
  final Function(String base64Image) onImageCreated;

  const DrawingCanvas({super.key, required this.onImageCreated});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  List<DrawingStroke> strokes = [];
  DrawingStroke? currentStroke;
  Color selectedColor = Colors.black;
  double strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 280,
            height: 280, // Canvas cuadrado más grande
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    currentStroke = DrawingStroke(points: [details.localPosition], color: selectedColor, strokeWidth: strokeWidth);
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    currentStroke?.points.add(details.localPosition);
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    if (currentStroke != null && currentStroke!.points.length > 1) {
                      strokes.add(currentStroke!);
                    }
                    currentStroke = null;
                  });
                },
                child: CustomPaint(
                  size: const Size(280, 280),
                  painter: DrawingPainter(strokes: strokes, currentStroke: currentStroke),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Controles de dibujo
        Row(
          children: [
            // Selector de color
            Expanded(
              child: Column(
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
            ),

            // Selector de grosor
            Expanded(
              child: Column(
                children: [
                  const Text('Grosor', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  Slider(
                    value: strokeWidth,
                    min: 1.0,
                    max: 15.0,
                    divisions: 14,
                    onChanged: (value) {
                      setState(() {
                        strokeWidth = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Botón limpiar
            Expanded(
              child: Column(
                children: [
                  const Text('Limpiar', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 4),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        strokes.clear();
                        currentStroke = null;
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        ElevatedButton(onPressed: strokes.isNotEmpty ? _saveImage : null, child: const Text('Guardar Dibujo')),
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

    // Dibujar el fondo blanco
    canvas.drawRect(const Rect.fromLTWH(0, 0, 280, 280), Paint()..color = Colors.white);

    // Dibujar todas las trazas
    for (final stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(280, 280);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    // Convertir a base64
    final base64String = base64Encode(bytes);
    widget.onImageCreated(base64String);
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingStroke> strokes;
  final DrawingStroke? currentStroke;

  DrawingPainter({required this.strokes, this.currentStroke});

  @override
  void paint(Canvas canvas, Size size) {
    // Dibujar todas las trazas completadas
    for (final stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = stroke.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }

    // Dibujar la traza actual
    if (currentStroke != null) {
      final paint = Paint()
        ..color = currentStroke!.color
        ..strokeWidth = currentStroke!.strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      for (int i = 0; i < currentStroke!.points.length - 1; i++) {
        canvas.drawLine(currentStroke!.points[i], currentStroke!.points[i + 1], paint);
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
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildColorButton(Colors.red),
            _buildColorButton(Colors.orange),
            _buildColorButton(Colors.yellow),
            _buildColorButton(Colors.green),
            _buildColorButton(Colors.blue),
            _buildColorButton(Colors.purple),
            _buildColorButton(Colors.pink),
            _buildColorButton(Colors.brown),
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
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.black,
      Colors.white,
    ];
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
    final paint = Paint();
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
