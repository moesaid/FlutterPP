import 'package:flutterpp/App/Models/profile_model.dart';
import 'package:flutterpp/App/Providers/Network/Auth/profile_provider.dart';

class ProfileServices {
  ProfileProvider profileProvider = ProfileProvider();

  // get auth profile
  Future<ProfileModel?> getAuthProfile() async {
    return await profileProvider.getAuthProfile();
  }
}
