import 'package:flutter/material.dart';

snackBar(Color bg, Color fg, IconData icon, String msg) {
  return SnackBar(
    backgroundColor: bg,
    content: Row(
      children: [
        Icon(icon, color: fg),
        const SizedBox(width: 10),
        Text(msg, style: TextStyle(fontSize: 16, color: fg)),
      ],
    ),
  );
}
