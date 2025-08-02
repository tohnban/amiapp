import 'package:flutter/material.dart';

class Privacidade extends StatefulWidget {
  const Privacidade({super.key});

  @override
  State<Privacidade> createState() => _PrivacidadeState();
}

class _PrivacidadeState extends State<Privacidade>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
