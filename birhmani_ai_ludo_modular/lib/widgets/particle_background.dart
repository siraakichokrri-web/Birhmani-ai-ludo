import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ParticleBackground extends StatelessWidget {
  final String asset;
  const ParticleBackground({this.asset='assets/animations/particles.riv'});
  @override Widget build(BuildContext context) {
    return Positioned.fill(child: Opacity(opacity: 0.12, child: RiveAnimation.asset(asset)));
  }
}
