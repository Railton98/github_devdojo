import 'package:flutter/material.dart';
import 'package:github_devdojo/models/content_model.dart';

class ListContent extends StatelessWidget {
  final List<ContentModel> contents;
  final Map<String, Widget> typeWidget = {
    'dir': const Icon(Icons.folder, color: Colors.blue),
    'file': const Icon(Icons.insert_drive_file, color: Colors.grey),
  };

  ListContent({Key key, this.contents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ContentModel> files = contents.where((f) => f.type == 'file').toList();
    final List<ContentModel> folders = contents.where((f) => f.type == 'dir').toList();
    folders.addAll(files);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      itemCount: folders.length,
      addAutomaticKeepAlives: false,
      itemBuilder: (BuildContext context, int index) {
        final ContentModel content = folders[index];
        final Widget icon = typeWidget[content.type];
        return ListTile(
          onTap: () {},
          leading: icon,
          title: Text(content.name),
        );
      },
    );
  }
}
