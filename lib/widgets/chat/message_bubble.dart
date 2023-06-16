import 'package:flutter/material.dart';
import 'package:genuine_app/models/chat_message_model.dart';

// A MessageBubble for showing a single chat message on the ChatScreen.
class MessageBubble extends StatelessWidget {
  // Create a message bubble that continues the sequence.
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  });

  final ChatMessage message;

  // Controls how the MessageBubble will be aligned.
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Row(
          // The side of the chat screen the message should show at.
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // The "speech" box surrounding the message.
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? theme.colorScheme.primary.withAlpha(200)
                          : Colors.white,
                      // Whether the "speaking edge" is on the left or right depends
                      // on whether or not the message bubble is the user.
                      borderRadius: BorderRadius.only(
                        bottomLeft:
                            !isMe ? Radius.zero : const Radius.circular(12),
                        bottomRight:
                            isMe ? Radius.zero : const Radius.circular(12),
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                      ),
                    ),
                    // Set some reasonable constraints on the width of the
                    // message bubble so it can adjust to the amount of text
                    // it should show.
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    // Margin around the bubble.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 5,
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        // Add a little line spacing to make the text look nicer
                        // when multilined.
                        height: 1.3,
                        color: isMe
                            ? theme.colorScheme.onSecondary
                            : Colors.black87,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
