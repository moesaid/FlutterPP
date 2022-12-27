import 'package:appwrite/appwrite.dart';
import 'package:flutterpp/Config/app_appwrite_client.dart';

class AuthProvider {
  // Create Account
  Future<Account> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    Client client = AppwriteClient().initClient();

    Account account = Account(client);

    await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );

    return account;
  }

  // Login
  Future<Account> login({
    required String email,
    required String password,
  }) async {
    Client client = AppwriteClient().initClient();

    Account account = Account(client);

    await account.createEmailSession(
      email: email,
      password: password,
    );

    return account;
  }

  // get account session
  Future<Account> getAccountSession() async {
    Client client = AppwriteClient().initClient();

    Account account = Account(client);

    return await account.get();

    // return account;
  }

  // create verification email
  Future<dynamic> createVerificationEmail({
    required String url,
  }) async {
    Client client = AppwriteClient().initClient();

    Account account = Account(client);

    var res = account.createVerification(
      url: url,
    );

    return res;
  }

  // verify email
  Future<dynamic> verifyEmail({
    required String userId,
    required String secret,
  }) async {
    Client client = AppwriteClient().initClient();

    Account account = Account(client);

    var res = account.updateVerification(
      secret: secret,
      userId: userId,
    );

    return res;
  }
}
