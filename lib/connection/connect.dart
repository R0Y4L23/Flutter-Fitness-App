import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static const String endpoint = 'https://cloud.appwrite.io/v1';
  static const String projectId = '6460d50b6e8d13ef64af';
  static final Client client =
      Client().setEndpoint(endpoint).setProject(projectId).setSelfSigned();
  static final Account account = Account(client);
  static final Databases databases = Databases(client);
}
