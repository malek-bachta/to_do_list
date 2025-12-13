import 'package:flutter/material.dart';
import 'dart:math' as math;

class ColorUtils {
  static final List _colors = [
    const Color(0xFF3B82F6),
    const Color(0xFF06B6D4),
    const Color(0xFF10B981),
    const Color(0xFF8B5CF6),
    const Color(0xFFF59E0B),
    const Color(0xFFEF4444),
    const Color(0xFF14B8A6),
    const Color(0xFF6366F1),
  ];

  static Color getRandomColor() {
    return _colors[math.Random().nextInt(_colors.length)];
  }
}
