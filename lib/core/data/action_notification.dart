import 'package:json_annotation/json_annotation.dart';
part 'action_notification.g.dart';

@JsonSerializable()
class ActionNotification {
  @JsonKey(name: 'entity_name')
  final ActionNotificationEntity entityName;
  @JsonKey(name: 'http_method')
  final ActionNotificationMethod httpMethod;
  final Map<String, dynamic>? data;

  ActionNotification({
    required this.entityName,
    required this.httpMethod,
    this.data,
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

  @JsonValue('assembly_join_request')
  assemblyJoinRequest,
}
