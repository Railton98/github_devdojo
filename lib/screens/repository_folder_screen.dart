import 'package:flutter/material.dart';
import 'package:github_devdojo/models/content_model.dart';
import 'package:github_devdojo/services/github_service.dart';
import 'package:github_devdojo/widgets/async_layout_constructor.dart';
import 'package:github_devdojo/widgets/list_content.dart';

class RepositoryFolderScreen extends StatelessWidget {
  final ContentModel content;

  const RepositoryFolderScreen({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(content.name),
        titleSpacing: 0,
      ),
      body: AsyncLayoutConstructor<List<ContentModel>>(
        future: GitHubService.findFolderByUrl(content.url),
        hasDataWidget: (data) => ListContent(contents: data),
        hasErrorWidget: (err) => const Center(child: const Text('Ocorreu um erro!!')),
        loadingWidget: () => const Center(child: const CircularProgressIndicator()),
        hasDataEmptyWidget: () => Container(),
      ),
    );
  }
}
