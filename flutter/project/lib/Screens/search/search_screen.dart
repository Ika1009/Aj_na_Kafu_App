import 'package:flutter/material.dart';
import 'package:project/screens/search/components/body.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SearchBody(),
    );
  }
}