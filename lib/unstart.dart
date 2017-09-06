import 'package:flutter/material.dart';
import 'package:redarx_flutter_example/requests.dart';



/// experimental: use notif instead of "injected" dispatch ?
/// new UnstartNotification<String>.add('test').dispatch(context);
///
/// autre piste : fmk light flutter only => notif => mapToCommand => exec return model
class UnstartNotification<T> extends Notification {
  RequestType type;
  T payload;

  UnstartNotification(RequestType type, this.payload);

  factory UnstartNotification.add(T value) =>
      new UnstartNotification(RequestType.ADD_TODO, value);
}
