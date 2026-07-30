import 'package:flutter/material.dart';

class HabitDiscoverView extends StatefulWidget {
  static const String route = '/habit_discover_view';
  const HabitDiscoverView({super.key});

  @override
  State<HabitDiscoverView> createState() => _HabitDiscoverViewState();
}

class _HabitDiscoverViewState extends State<HabitDiscoverView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Discover')),
      body: SafeArea(child: Column(children: [])),
    );
  }
}

