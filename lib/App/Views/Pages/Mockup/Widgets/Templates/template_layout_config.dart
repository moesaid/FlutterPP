import 'package:flutterpp/App/Enums/template_layout_enum.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/left_side_title_below.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/right_side_title_below.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/rotate_right_four.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/rotate_right_one.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/rotate_right_three.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/rotate_right_two.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_down.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/title_up.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/two_devices_connected_left_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/two_devices_connected_right_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/two_devices_title_above.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/two_devices_title_below.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/two_devices_top_left_bottom_right.dart';
import 'package:flutterpp/App/Views/Pages/Mockup/Widgets/Templates/Types/two_devices_top_right_bottom_left.dart';

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
      case TemplateLayoutEnum.rotateRightOne:
        return rotateRightOne();
      case TemplateLayoutEnum.rotateRightTwo:
        return rotateRightTwo();
      case TemplateLayoutEnum.rotateRightThree:
        return rotateRightThree();
      case TemplateLayoutEnum.rotateRightFour:
        return rotateRightFour();
      case TemplateLayoutEnum.twoDevicesTitleAbove:
        return twoDevicesTitleAbove();
      case TemplateLayoutEnum.twoDevicesTitleBelow:
        return twoDevicesTitleBelow();
      case TemplateLayoutEnum.twoDevicesTopRightBottomLeft:
        return twoDevicesTopRightBottomLeft();
      case TemplateLayoutEnum.twoDevicesTopLeftBottomRight:
        return twoDevicesTopLeftBottomRight();
      case TemplateLayoutEnum.twoDevicesConnectedRightTitleAbove:
        return twoDevicesConnectedRightTitleAbove();
      case TemplateLayoutEnum.twoDevicesConnectedLeftTitleAbove:
        return twoDevicesConnectedLeftTitleAbove();

      default:
        return titleUp();
    }
  }
}
