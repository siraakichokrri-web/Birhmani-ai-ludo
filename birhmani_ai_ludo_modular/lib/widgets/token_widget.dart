import 'package:flutter/material.dart';

class TokenWidget extends StatelessWidget {
  final Color color;
  TokenWidget({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(width:20,height:20, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}
