import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Providers/Network/Invoice/invoice_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';

class InvoiceServices {
  final InvoiceProvider _provider = InvoiceProvider();
  final CallPipeline _callPipeline = CallPipeline();
  final TeamServices _teamServices = TeamServices();

  // get invoices by team id
  Future<List<InvoiceModel>?> getInvoicesByTeamId() async {
    // get team
    final team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return _callPipeline.futurePipeline(
      future: () => _provider.getInvoicesByTeamId(teamId: team.id!),
      name: 'getInvoicesByTeamId',
    );
  }

  // get invoice by id
  Future<InvoiceModel?> getInvoiceById({required String invoiceId}) async {
    return _callPipeline.futurePipeline(
      future: () => _provider.getInvoiceById(invoiceId: invoiceId),
      name: 'getInvoiceById',
    );
  }

  // create invoice
  Future<InvoiceModel?> createInvoice({
    required InvoiceModel invoice,
  }) async {
    // get team
    final team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return _callPipeline.futurePipeline(
      future: () => _provider.createInvoice(
        invoice: invoice.copyWith(teamId: team.id!),
      ),
      name: 'createInvoice',
    );
  }

  // update invoice
  Future<InvoiceModel?> updateInvoice({
    required InvoiceModel invoice,
  }) async {
    return _callPipeline.futurePipeline(
      future: () => _provider.updateInvoice(invoice: invoice),
      name: 'updateInvoice',
    );
  }

  // delete invoice
  Future<bool> deleteInvoice({required String invoiceId}) async {
    bool? data = await _callPipeline.futurePipeline(
      future: () => _provider.deleteInvoice(invoiceId: invoiceId),
      name: 'deleteInvoice',
    );

    return data ?? false;
  }
}
