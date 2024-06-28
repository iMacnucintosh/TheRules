import 'package:flutter/material.dart';

class Rule {
  Rule({
    required this.imagePath,
    required this.name,
    required this.description,
    this.enabled = false,
    this.child,
    this.onFinish,
  });

  String imagePath;
  String name;
  String description;
  bool enabled;
  Widget? child;
  Function? onFinish;
}
