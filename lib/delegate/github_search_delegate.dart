import 'package:flutter/material.dart';
import 'package:github_devdojo/models/repository.dart';
import 'package:github_devdojo/services/github_service.dart';
import 'package:github_devdojo/utils/pagination.dart';

class GitHubSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];
    }

    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    return RepositoryList(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return ListTile(
      leading: const Icon(Icons.book),
      title: Text('Repositórios com $query'),
      onTap: () => showResults(context),
    );
  }

  @override
  String get searchFieldLabel => 'Pesquisar';
}

class RepositoryList extends StatefulWidget {
  final String query;

  const RepositoryList({Key key, @required this.query}) : super(key: key);
  @override
  _RepositoryListState createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pagination<Repository>>(
      future: GitHubService.findAllRepositoryByName(widget.query, page),
      builder: (BuildContext context, AsyncSnapshot<Pagination<Repository>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro!'));
        }

        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.items.length,
            itemBuilder: (context, index) {
              return Text("${snapshot.data.items[index].name}");
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
