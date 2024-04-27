import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TodoListPage extends StatelessWidget {

  final WidgetBuilder _page; 
  final List<SingleChildWidget>? _bindings; 


  TodoListPage({ Key? key, required WidgetBuilder page, List<SingleChildWidget>? bindings}) : _bindings = bindings, _page = page, super(key: key);

   @override
   Widget build(BuildContext context) {
      return MultiProvider(
        providers: _bindings ?? [Provider(create: (_) => Object())], // Multiprovider não pode ser vazio, temos que enviar pelo menos 1
        child: Builder(builder: 
        (context) => _page(context)
        )
        ); 
  }
}