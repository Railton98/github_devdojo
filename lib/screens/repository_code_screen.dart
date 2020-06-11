import 'package:flutter/material.dart';
import 'package:github_devdojo/models/content_model.dart';
import 'package:github_devdojo/models/repository.dart';
import 'package:github_devdojo/services/github_service.dart';
import 'package:github_devdojo/widgets/async_layout_constructor.dart';

class RepositoryCodeScreen extends StatefulWidget {
  final Repository repository;

  const RepositoryCodeScreen({Key key, this.repository}) : super(key: key);

  @override
  _RepositoryCodeScreenState createState() => _RepositoryCodeScreenState();
}

class _RepositoryCodeScreenState extends State<RepositoryCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AsyncLayoutConstructor<List<ContentModel>>(
        future: GitHubService.findAllContentsByFullName(widget.repository.fullName),
        hasDataWidget: (data) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [],
            body: const Center(
              child: const Text('OK'),
            ),
          );
        },
        hasErrorWidget: (err) => const Center(child: const Text('Ocorreu um erro!!')),
        loadingWidget: () => const Center(child: const CircularProgressIndicator()),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }
}
