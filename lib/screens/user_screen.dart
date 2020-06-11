import 'package:flutter/material.dart';
import 'package:github_devdojo/models/user_model.dart';
import 'package:github_devdojo/services/github_service.dart';
import 'package:github_devdojo/widgets/async_layout_constructor.dart';
import 'package:github_devdojo/widgets/widget_call_safe.dart';

class UserScreen extends StatefulWidget {
  final String url;

  const UserScreen({Key key, this.url}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with AutomaticKeepAliveClientMixin<UserScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: AsyncLayoutConstructor<UserModel>(
        future: GitHubService.findUserByUrl(widget.url),
        hasDataWidget: (user) {
          return NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [],
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.network(user.avatarUrl),
                    title: Text('${user.name}'),
                    subtitle: Text('${user.login}'),
                  ),
                  WidgetCallSafe(
                    checkIfNull: () => user.email != null && user.bio != null,
                    success: () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          WidgetCallSafe(
                            checkIfNull: () => user.email != null,
                            success: () {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text('${user.email}'),
                              );
                            },
                            fail: () => Container(),
                          ),
                          WidgetCallSafe(
                            checkIfNull: () => user.bio != null,
                            success: () {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text('${user.bio}'),
                              );
                            },
                            fail: () => Container(),
                          ),
                          WidgetCallSafe(
                            checkIfNull: () => user.company != null,
                            success: () {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.people),
                                title: Text('${user.company}'),
                              );
                            },
                            fail: () => Container(),
                          ),
                          WidgetCallSafe(
                            checkIfNull: () => user.location != null,
                            success: () {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.person_pin_circle),
                                title: Text('${user.location}'),
                              );
                            },
                            fail: () => Container(),
                          ),
                        ],
                      );
                    },
                    fail: () => Container(),
                  ),
                ],
              ),
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
