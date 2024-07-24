import 'package:flutter/material.dart';

class Rule {
  Rule({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.description,
    this.enabled = false,
    this.child,
    this.onFinish,
  });

  String id;
  String imagePath;
  String name;
  String description;
  bool enabled;
  Widget? child;
  Function? onFinish;
}
