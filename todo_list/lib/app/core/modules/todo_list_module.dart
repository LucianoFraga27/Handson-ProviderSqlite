import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routers; //
  final List<SingleChildWidget>?
      _bindings; // providers são filhos de single child widget

  TodoListModule(
      {List<SingleChildWidget>? bindings,
      required Map<String, WidgetBuilder> routers})
      : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => TodoListPage(bindings: _bindings, page: pageBuilder),
      ),
    );
  }
}
