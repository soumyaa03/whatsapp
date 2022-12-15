import 'package:whatsapp/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String recieverId;
  final String text;
  final MessageEnum type;
  final DateTime timesent;
  final String messageId;
  final bool isSeen;
  Message({
    required this.senderId,
    required this.recieverId,
    required this.text,
    required this.type,
    required this.timesent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'text': text,
      'type': type.type,
      'timesent': timesent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverId: map['recieverId'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as MessageEnum),
      timesent: DateTime.fromMillisecondsSinceEpoch(map['timesent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}
