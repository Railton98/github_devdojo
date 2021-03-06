import 'package:flutter/material.dart';

class AsyncLayoutConstructor<T> extends StatefulWidget {
  final Future<T> future;
  final T initialData;

  final Widget Function(T data) hasDataWidget;
  final Widget Function() hasDataEmptyWidget;
  final Widget Function(Object err) hasErrorWidget;
  final Widget Function() loadingWidget;

  const AsyncLayoutConstructor({
    Key key,
    this.future,
    this.initialData,
    @required this.hasDataWidget,
    @required this.hasDataEmptyWidget,
    @required this.hasErrorWidget,
    @required this.loadingWidget,
  }) : super(key: key);

  @override
  _AsyncLayoutConstructorState<T> createState() => _AsyncLayoutConstructorState<T>();
}

class _AsyncLayoutConstructorState<T> extends State<AsyncLayoutConstructor<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.future,
      initialData: widget.initialData,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasData) {
          return widget.hasDataWidget(snapshot.data);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget();
        }

        if (snapshot.hasError) {
          return widget.hasErrorWidget(snapshot.error);
        }

        return widget.hasDataEmptyWidget();
      },
    );
  }
}
