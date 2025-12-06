import 'package:flutter/material.dart';

class FilterModel {
  final String text;
  final IconData? icon;
final  void Function()? onTap;

  FilterModel({required this.text,  this.icon,  this.onTap});
}
