import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({required this.changeNotifier});

  void listener(
      {required BuildContext context,
      required SuccessVoidCallBack successCallBack,
      ErrorVoidCallBack? errorCallBack
      }) {
    changeNotifier.addListener(() {
      // verifica se está no loading
      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      // verfica se existe erro
      if (changeNotifier.hasError) {
        if (errorCallBack != null) {
          errorCallBack(changeNotifier,this);
        }
        Messages.of(context).showError(changeNotifier.error ?? "Erro Interno");
      } else if (changeNotifier.isSuccess) {
        successCallBack(changeNotifier, this);
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listener);


typedef ErrorVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listener);
