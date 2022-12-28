import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/features/chat/widgets/video_player_item.dart';

class DisplayMessageTextImageVideoGif extends StatelessWidget {
  final String message;
  final dynamic type;
  const DisplayMessageTextImageVideoGif({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == 'text'
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == 'image'
            ? CachedNetworkImage(
                imageUrl: message,
              )
            : VideoPlayerItem(
                videoUrl: message,
              );
  }
}
