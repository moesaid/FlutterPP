import 'package:logger/logger.dart';

class AppPrint {
  // print
  static print(dynamic data) {
    Logger(printer: PrettyPrinter(methodCount: 0)).i(data.toString());
  }

  // print error
  static printError(dynamic data) {
    Logger(printer: PrettyPrinter(methodCount: 0)).e(data.toString());
  }

  // print warning
  static printWarning(dynamic data) {
    Logger(printer: PrettyPrinter(methodCount: 0)).w(data.toString());
  }

  // print debug
  static printDebug(dynamic data) {
    Logger(printer: PrettyPrinter(methodCount: 0)).d(data.toString());
  }

  // print verbose
  static printVerbose(dynamic data) {
    Logger(printer: PrettyPrinter(methodCount: 0)).t(
      data.toString(),
      stackTrace: StackTrace.current,
    );
  }
}
