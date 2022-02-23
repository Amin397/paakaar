import 'package:flutter/material.dart';

class CharityIconModel {
  String name;
  IconData icon;

  CharityIconModel({
    required this.name,
    this.icon = Icons.favorite,
  });
}
