import 'package:get/get.dart';

class InvoiceIndexController extends GetxController {
  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _clients = 0.obs;
  int get clients => _clients.value;

  final _invoices = 0.obs;
  int get invoices => _invoices.value;

  final _outstanding = 0.obs;
  int get outstanding => _outstanding.value;

  final _overdue = 0.obs;
  int get overdue => _overdue.value;

  final _filter = 'draft'.obs;
  String get filter => _filter.value;

  final _length = 10.obs;
  int get length => _length.value;

  // on filter change
  void onFilterChange(String value) {
    _filter.value = value;
    update();
  }

  // on length change
  void onLengthChange(int value) {
    _length.value = value;
    update();
  }

  // view single invoice
  void viewInvoice(String id) {
    print(id);
  }

  // delete single invoice
  void deleteInvoice(String id) {
    print(id);
  }

  // edit single invoice
  void editInvoice(String id) {
    print(id);
  }

  // duplicate single invoice
  void duplicateInvoice(String id) {
    print(id);
  }

  // export as pdf
  void exportAsPdf(String id) {
    print(id);
  }

  // print invoice
  void printInvoice(String id) {
    print(id);
  }
}
