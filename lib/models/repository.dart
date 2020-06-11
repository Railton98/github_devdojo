import 'package:github_devdojo/models/user_model.dart';

class Repository {
  String name;
  String fullName;
  String description;
  String language;
  UserModel owner;
  int stars;

  Repository.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.fullName = json['full_name'],
        this.description = json['description'],
        this.language = json['language'],
        this.owner = json['owner'] != null ? UserModel.fromJson(json['owner']) : null,
        this.stars = json['stargazers_count'];
}
