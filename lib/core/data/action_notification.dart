import 'package:json_annotation/json_annotation.dart';
part 'action_notification.g.dart';

@JsonSerializable()
class ActionNotification {
  final ActionNotificationEntity entity;
  final ActionNotificationMethod method;

  ActionNotification({
    required this.entity,
    required this.method,
  });

  Map<String, dynamic> toJson() => _$ActionNotificationToJson(this);

  factory ActionNotification.fromJson(Map<String, dynamic> json) =>
      _$ActionNotificationFromJson(json);
}

enum ActionNotificationMethod {
  @JsonValue('POST')
  post,
}

enum ActionNotificationEntity {
  @JsonValue('assembly')
  assembly,
}
