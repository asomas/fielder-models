import 'package:fielder_models/core/db_models/old/schema/conversation_schema.dart';

class ConversationModel {
  final String conversationId;
  final String conversationType;
  final MessageModel lastMessage;
  final ConversationWith conversationWith;
  final int unreadMessageCount;

  ConversationModel(
      {this.conversationId,
      this.conversationType,
      this.lastMessage,
      this.conversationWith,
      this.unreadMessageCount});

  factory ConversationModel.fromMap(map) {
    try {
      return ConversationModel(
        conversationId: map[ConversationSchema.conversationId],
        conversationType: map[ConversationSchema.conversationType],
        conversationWith: map[ConversationSchema.conversationWith] != null
            ? ConversationWith.fromMap(map[ConversationSchema.conversationWith])
            : null,
        lastMessage: map[ConversationSchema.lastMessage] != null
            ? MessageModel.fromMap(
                map[ConversationSchema.lastMessage][ConversationSchema.data])
            : null,
        unreadMessageCount: map[ConversationSchema.unreadMessageCount],
      );
    } catch (e, s) {
      print('conversation model catch_____${e}_____$s');
      return null;
    }
  }
}

class MessageModel {
  String text;
  MessageData sender;
  MessageData receiver;

  MessageModel({this.text, this.sender, this.receiver});

  factory MessageModel.fromMap(Map map) {
    try {
      MessageData _sender, _receiver;
      if (map[ConversationSchema.entities] != null) {
        _sender = MessageData.fromMap(
            map[ConversationSchema.entities][ConversationSchema.sender]);
        _receiver = MessageData.fromMap(
            map[ConversationSchema.entities][ConversationSchema.receiver]);
      }
      return MessageModel(
        text: map[ConversationSchema.text],
        sender: _sender,
        receiver: _receiver,
      );
    } catch (e, s) {
      print("message model catch____${e}_______$s");
      return null;
    }
  }
}

class MessageData {
  String uid;
  String name;
  String role;
  String status;
  num lastActive;
  String entityType;

  MessageData({
    this.uid,
    this.name,
    this.role,
    this.status,
    this.lastActive,
    this.entityType,
  });

  factory MessageData.fromMap(Map map) {
    try {
      MessageData data = MessageData(
        entityType: map[ConversationSchema.entityType],
      );
      if (map[ConversationSchema.entity] != null) {
        Map entity = map[ConversationSchema.entity];
        data.uid = entity[ConversationSchema.uid];
        data.name = entity[ConversationSchema.name];
        data.role = entity[ConversationSchema.role];
        data.status = entity[ConversationSchema.status];
        data.lastActive = entity[ConversationSchema.lastActiveAt];
      }
      return data;
    } catch (e, s) {
      print("message data model catch____${e}_______$s");
      return null;
    }
  }
}

class ConversationWith {
  String uid;
  String name;
  String role;
  String status;
  num lastActive;
  num deactivatedAt;
  bool hasBlockedMe;
  bool blockedByMe;

  ConversationWith({
    this.uid,
    this.name,
    this.role,
    this.status,
    this.lastActive,
    this.deactivatedAt,
    this.blockedByMe,
    this.hasBlockedMe,
  });

  factory ConversationWith.fromMap(Map map) {
    try {
      return ConversationWith(
        uid: map[ConversationSchema.uid],
        name: map[ConversationSchema.name],
        role: map[ConversationSchema.role],
        status: map[ConversationSchema.status],
        lastActive: map[ConversationSchema.lastActiveAt],
        deactivatedAt: map[ConversationSchema.deactivatedAt],
        blockedByMe: map[ConversationSchema.blockedByMe] ?? false,
        hasBlockedMe: map[ConversationSchema.hasBlockedMe] ?? false,
      );
    } catch (e, s) {
      print("conversation with model catch____${e}_______$s");
      return null;
    }
  }
}
