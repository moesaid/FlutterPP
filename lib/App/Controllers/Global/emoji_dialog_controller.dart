import 'package:emojis/emoji.dart';
import 'package:get/get.dart';

class EmojiDialogController extends GetxController {
  final _emojiList = <Emoji>[].obs;
  List<Emoji> get emojiList => _emojiList;

  final _activeGroup = EmojiGroup.smileysEmotion.obs;
  EmojiGroup get activeGroup => _activeGroup.value;

  @override
  void onInit() {
    _emojiList.addAll(Emoji.byGroup(EmojiGroup.smileysEmotion));
    super.onInit();
  }

  // change active group
  changeActiveGroup(EmojiGroup group) {
    _activeGroup.value = group;
    _emojiList.clear();

    // remove renbow_flag if exists
    if (group == EmojiGroup.flags) {
      _emojiList.addAll(
        Emoji.byGroup(group).where((e) =>
            ['rainbow_flag', 'transgender_flag', 'flag_il']
                .contains(e.shortName) ==
            false),
      );
    } else if (group == EmojiGroup.symbols) {
      _emojiList.addAll(
        Emoji.byGroup(group).where((e) =>
            [
              'star_of_david',
              'six_pointed_star',
              'menorah',
              'transgender_symbol'
            ].contains(e.shortName) ==
            false),
      );
    } else {
      _emojiList.addAll(Emoji.byGroup(group));
    }

    update();
  }
}
