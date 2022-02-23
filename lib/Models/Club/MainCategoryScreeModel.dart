import 'package:paakaar/Plugins/get/get.dart';
import 'package:flutter/material.dart';

class MainCategoryModel {
  bool? isSelected = false;
  int? id;
  String? name;
  String? imagePath;
  GetPage? screenWidget;
  IconData? icon;
  MainCategoryModel({
    this.isSelected,
    this.id,
    this.name,
    this.imagePath,
    this.screenWidget,
    this.icon = Icons.add,
  });
}
