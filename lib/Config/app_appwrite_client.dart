import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  // expose the client
  Client initClient() {
    Client client = Client();
    return client
        .setEndpoint('http://localhost:1111/v1')
        .setProject('63a8f2c584e33bf35c48')
        .setSelfSigned(status: true);
  }
}
