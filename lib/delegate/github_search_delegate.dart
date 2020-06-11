import 'package:flutter/material.dart';
import 'package:github_devdojo/models/repository.dart';
import 'package:github_devdojo/services/github_service.dart';
import 'package:github_devdojo/utils/pagination.dart';
import 'package:github_devdojo/widgets/async_layout_constructor.dart';
import 'package:github_devdojo/widgets/text_icon.dart';

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
    return AsyncLayoutConstructor<Pagination<Repository>>(
      future: GitHubService.findAllRepositoryByName(widget.query, page),
      hasDataWidget: (data) {
        return ListView.builder(
          itemCount: data.items.length,
          itemBuilder: (context, index) {
            return RepositoryView(repository: data.items[index]);
          },
        );
      },
      hasErrorWidget: (err) => Center(child: Text('Erro!')),
      loadingWidget: () => Center(child: CircularProgressIndicator()),
      hasDataEmptyWidget: () => Container(),
    );
  }
}

class RepositoryView extends StatelessWidget {
  final Repository repository;

  const RepositoryView({Key key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: <Widget>[
                Image.network(repository.owner.avatarUrl, width: 32, height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(repository.owner.login),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            title: Text(repository.name),
            subtitle: Text(repository?.description ?? 'Sem descrição!'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: Text(repository?.language ?? 'Não definida')),
                TextIcon(
                  title: '${repository.stars}',
                  icon: const Icon(Icons.stars, color: Colors.amberAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
