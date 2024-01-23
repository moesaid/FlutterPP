import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/device_advance_rotate_right_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/device_rotate_right_title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_up.dart';
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
      case TemplateLayoutEnum.rightSideTitleUp:
        return rightSideTitleUp();
      case TemplateLayoutEnum.leftSideTitleUp:
        return leftSideTitleUp();
      case TemplateLayoutEnum.rightSideTitleDown:
        return rightSideTitleDown();
      case TemplateLayoutEnum.leftSideTitleDown:
        return leftSideTitleDown();
      case TemplateLayoutEnum.deviceRotateRightTitleUp:
        return deviceRotateRightTitleUp();
      case TemplateLayoutEnum.deviceAdvanceRotateRightTitleDown:
        return deviceAdvanceRotateRightTitleDown();
      default:
        return titleUp();
    }
  }
}
