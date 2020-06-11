import 'package:flutter/foundation.dart';

class Pagination<T> {
  final int total;
  final List<T> items;

  const Pagination({
    @required this.total,
    @required this.items,
  });
}
