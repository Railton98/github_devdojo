import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:github_devdojo/models/content_model.dart';
import 'package:github_devdojo/services/github_service.dart';
import 'package:github_devdojo/widgets/async_layout_constructor.dart';
import 'package:github_devdojo/widgets/widget_call_safe.dart';

class RepositoryContentBlobScreen extends StatelessWidget {
  final Base64Codec base64codec = Base64Codec();
  final Utf8Codec utf8codec = Utf8Codec();
  final ContentModel content;

  RepositoryContentBlobScreen({Key key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              titleSpacing: 0,
              title: Text(content.name ?? content.path),
            ),
          ];
        },
        body: AsyncLayoutConstructor<ContentModel>(
          future: GitHubService.findFileByUrl(content.url),
          hasDataWidget: (data) {
            final String decodeContent = tryDecode(data);
            return WidgetCallSafe(
              checkIfNull: () => decodeContent != null,
              success: () {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: HighlightView(
                      decodeContent,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      theme: githubTheme,
                      language: 'javascript',
                    ),
                  ),
                );
              },
              fail: () => const Center(child: const Text('Não foi possível ler o arquivo!')),
            );
          },
          hasErrorWidget: (err) => const Center(child: const Text('Ocorreu um erro!!')),
          loadingWidget: () => const Center(child: const CircularProgressIndicator()),
          hasDataEmptyWidget: () => Container(),
        ),
      ),
    );
  }

  String tryDecode(ContentModel content) {
    try {
      return utf8codec.decode(base64codec.decode(content.content.replaceAll('\n', '')));
    } catch (e) {
      print(e);
      return null;
    }
  }
}
