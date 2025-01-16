import 'package:recyclomator/domain/entities/message.dart';
import 'package:recyclomator/infrastructure/repositories/firestore.dart';

class ChatService {
  ChatService(
    this._messageRepository,
  );

  final FirestoreRepository<Message> _messageRepository;

  Future<void> sendMessage(String offerId, String senderId, String text) async {
    final message = Message(
      id: '',
      offerId: offerId,
      senderId: senderId,
      text: text,
    );
    await _messageRepository.add(message);
  }

  Stream<List<Message>> getMessages(String offerId) {
    return _messageRepository.observeDocuments().map(
          (List<Message> messages) => messages
              .where((Message message) => message.offerId == offerId)
              .toList()
              ..sort((a, b) => a.timestamp.compareTo(b.timestamp)),
        );
  }

}
