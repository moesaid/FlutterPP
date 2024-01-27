import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_below.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_below.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_up.dart';

class TemplateLayoutConfig {
  // swich case returns
  Map<String, dynamic> getLayoutConfig(TemplateLayoutEnum type) {
    switch (type) {
      case TemplateLayoutEnum.titleUp:
        return titleUp();
      case TemplateLayoutEnum.titleDown:
        return titleDown();
      case TemplateLayoutEnum.rightSideTitleAbove:
        return rightSideTitleAbove();
      case TemplateLayoutEnum.leftSideTitleAbove:
        return leftSideTitleAbove();
      case TemplateLayoutEnum.rightSideTitleBelow:
        return rightSideTitleBelow();
      case TemplateLayoutEnum.leftSideTitleBelow:
        return leftSideTitleBelow();
      default:
        return titleUp();
    }
  }
}
