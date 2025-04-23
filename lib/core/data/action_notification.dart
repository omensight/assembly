import 'package:json_annotation/json_annotation.dart';
part 'action_notification.g.dart';

@JsonSerializable()
class ActionNotification {
  @JsonKey(name: 'entity_name')
  final ActionNotificationEntity entityName;
  @JsonKey(name: 'notification_type')
  final InstanceNotificationType notificationType;
  final Map<String, dynamic>? data;

  ActionNotification({
    required this.entityName,
    required this.notificationType,
    this.data,
  });

  Map<String, dynamic> toJson() => _$ActionNotificationToJson(this);

  factory ActionNotification.fromJson(Map<String, dynamic> json) =>
      _$ActionNotificationFromJson(json);
}

enum InstanceNotificationType {
  @JsonValue('save')
  save,
  @JsonValue('delete')
  delete,
}

enum ActionNotificationEntity {
  @JsonValue('assembly')
  assembly,

  @JsonValue('assembly_join_request')
  assemblyJoinRequest,

  @JsonValue('assembly_member')
  assemblyMember,
}
