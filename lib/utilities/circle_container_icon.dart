import 'package:flutter/material.dart';

GestureDetector circle_container_icon(icon,
    {height = 40.0, width = 40.0, background_color = Colors.black12, onTap}) {
  return GestureDetector(
    child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: background_color,
        ),
        child: icon),
    onTap: onTap,
  );
}
