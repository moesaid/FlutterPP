import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_up.dart';

class TemplateLayoutConfig {
  // swich case returns
  Map<String, dynamic> getLayoutConfig(type) {
    switch (type) {
      case TemplateLayoutEnum.titleUp:
        return titleUp();
      case TemplateLayoutEnum.titleDown:
        return titleDown();

      default:
        return titleUp();
    }
  }
}
