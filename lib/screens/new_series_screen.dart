import 'package:flutter/material.dart';

class NewSeriesScreen extends StatefulWidget {
  const NewSeriesScreen({super.key});

  @override
  State<NewSeriesScreen> createState() => _NewSeriesScreenState();
}

class _NewSeriesScreenState extends State<NewSeriesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("new series"),);
  }
}