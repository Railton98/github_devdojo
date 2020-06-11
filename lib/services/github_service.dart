import 'dart:convert';

import 'package:github_devdojo/http/http_provider.dart';
import 'package:github_devdojo/models/repository.dart';
import 'package:github_devdojo/models/user_model.dart';
import 'package:github_devdojo/utils/api_path.dart';
import 'package:github_devdojo/utils/pagination.dart';

abstract class GitHubService {
  static Future<Pagination<Repository>> findAllRepositoryByName(String name, int page) async {
    var response = await HttpProvider.get('$apiPath/search/repositories?q=$name&page=$page');

    var keyMap = json.decode(response.body);

    Iterable iterable = keyMap['items'];
    List<Repository> repositories = iterable.map((repository) => Repository.fromJson(repository)).toList();

    return Pagination<Repository>(total: keyMap['total_count'], items: repositories);
  }

  static Future<UserModel> findUserByUrl(String url) async {
    final response = await HttpProvider.get(url);

    return UserModel.fromJson(json.decode(response.body));
  }
}
