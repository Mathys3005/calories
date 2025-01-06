import 'dart:ui';

import 'package:flutter/material.dart';

class BottomAction{
  final String texte;
  final IconData icon;
  final VoidCallback onPressed;

  BottomAction({
    required this.texte,
    required this.icon,
    required this.onPressed,
  });

}