import 'package:flutter/material.dart';
import 'package:github_devdojo/delegate/github_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo ao GitHub'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: GitHubSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: const Text('Buscar repositóris públicos'),
      ),
    );
  }
}
