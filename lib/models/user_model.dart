class UserModel {
  String name;
  String login;
  String avatarUrl;
  String url;
  String bio;
  String company;
  String location;
  String email;

  UserModel.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.login = json['login'],
        this.avatarUrl = json['avatar_url'],
        this.url = json['url'],
        this.bio = json['bio'],
        this.company = json['company'],
        this.location = json['location'],
        this.email = json['email'];
}
