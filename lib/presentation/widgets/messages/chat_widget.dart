import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recyclomator/domain/entities/message.dart';
import 'package:recyclomator/domain/entities/offer.dart';
import 'package:recyclomator/infrastructure/services/chat_service.dart';
import 'package:recyclomator/infrastructure/services/user_service.dart';
import 'package:recyclomator/presentation/templates/page_template.dart';
import 'package:recyclomator/presentation/widgets/common/stream_widget.dart';
import 'package:recyclomator/presentation/widgets/messages/message_widget.dart';

class ChatWidget extends StatelessWidget {
  ChatWidget({super.key, required this.offer});
  final Offer offer;

  final ChatService _chatService = GetIt.I<ChatService>();
  final UserService _userService = GetIt.I<UserService>();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: Text('Chat'),
      child: Column(
        children: [
          Expanded(
            child: StreamWidget<List<Message>>(
              stream: _chatService.getMessages(offer.id!),
              onData: (messages) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageWidget(
                      message: message,
                      userId: _userService.currentUserId,
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Type a message',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final text = controller.text;
              if (text.isNotEmpty) {
                _chatService.sendMessage(
                  offer.id!,
                  _userService.currentUserId,
                  text,
                );
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
