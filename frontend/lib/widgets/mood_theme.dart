import 'package:flutter/material.dart';

class MoodColors {
  final Color primary;
  final Color secondary;
  final Color accent;

  const MoodColors({
    required this.primary,
    required this.secondary,
    required this.accent,
  });
}

class MoodTheme {
  static MoodColors getMoodColors(String mood) {
    switch (mood.toLowerCase()) {

      case "happy":
        return const MoodColors(
          primary: Color(0xFFFFD93D),   // Sunshine Yellow
          secondary: Color(0xFFFF8A5C), // Warm Orange
          accent: Color(0xFFF9E076),    // Soft Gold
        );

      case "sad":
        return const MoodColors(
          primary: Color(0xFF6C9EBF),   // Soft Blue
          secondary: Color(0xFF9B9FB5), // Dusty Lavender
          accent: Color(0xFFC7D3DD),    // Misty Gray
        );

      case "angry":
        return const MoodColors(
          primary: Color(0xFFD14D4D),   // Deep Red
          secondary: Color(0xFFC45D42), // Burnt Orange
          accent: Color(0xFF8B3A3A),    // Dark Burgundy
        );

      case "calm":
        return const MoodColors(
          primary: Color(0xFF8FBC94),   // Sage Green
          secondary: Color(0xFFA5D6D9), // Soft Teal
          accent: Color(0xFFC5E0D4),    // Misty Mint
        );

      case "anxious":
        return const MoodColors(
          primary: Color(0xFFB8A9C9),   // Soft Lavender
          secondary: Color(0xFF9B8BB0), // Muted Purple
          accent: Color(0xFFD9D0DE),    // Light Gray
        );

      case "frustrated":
        return const MoodColors(
          primary: Color(0xFFC96E6E),   // Terracotta
          secondary: Color(0xFFB85C5C), // Dusty Rose
          accent: Color(0xFFE8C7B5),    // Warm Beige
        );

      case "surprised":
        return const MoodColors(
          primary: Color(0xFF9B5DE5),   // Electric Purple
          secondary: Color(0xFFF15BB5), // Bright Fuchsia
          accent: Color(0xFF00BBF9),    // Vibrant Blue
        );

      case "neutral":
        return const MoodColors(
          primary: Color(0xFFBEBEBE),   // Warm Gray
          secondary: Color(0xFFF5F0E1), // Soft Beige
          accent: Color(0xFFC7B8A5),    // Muted Taupe
        );

      default:
        return const MoodColors(
          primary: Color(0xFF9E9E9E),
          secondary: Color(0xFFBDBDBD),
          accent: Color(0xFFE0E0E0),
        );
    }
  }
}