// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Providers/Device/file_maneger_provider.dart';
import 'package:flutterpp/App/Providers/Network/Invoice/invoice_provider.dart';
import 'package:flutterpp/App/Services/Client/client_services.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Pages/Invoice/Widgets/build_invoice_printable_body.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

class InvoiceServices {
  final InvoiceProvider _provider = InvoiceProvider();
  final CallPipeline _callPipeline = CallPipeline();
  final TeamServices _teamServices = TeamServices();
  final ClientServices _clientServices = ClientServices();
  final FileManegerProvider _fileManegerProvider = FileManegerProvider();
  final ScreenshotController _screenshotController = ScreenshotController();

  // get invoices by team id
  Future<List<InvoiceModel>?> getInvoicesByTeamId({int? limit}) async {
    // get team
    final team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return _callPipeline.futurePipeline(
      future: () => _provider.getInvoicesByTeamId(
        teamId: team.id!,
        limit: limit,
      ),
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
    bool? customCreatedAt,
  }) async {
    // get team
    final team = await _teamServices.getTeamForAuthUser();

    if (team == null || team.id == null) return null;

    return _callPipeline.futurePipeline(
      future: () => _provider.createInvoice(
        invoice: invoice.copyWith(teamId: team.id!),
        customCreatedAt: customCreatedAt,
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

  // download invoice
  Future<void> downloadOrPrintInvoice({
    required InvoiceModel invoice,
    TeamModel? team,
    ClientModel? client,
    bool? isPrint,
  }) async {
    TeamModel? localTeam = team;
    ClientModel? localClient = client;

    await _callPipeline.futurePipeline(
      future: () async {
        if (localTeam?.id == null || localClient?.id == null) {
          await Get.showOverlay(
            asyncFunction: () async {
              if (localTeam?.id == null) {
                localTeam = await _teamServices.getTeamForAuthUser();
              }

              if (localClient?.id == null) {
                localClient = await _clientServices.getClientById(
                  clientId: invoice.clientId!,
                );
              }
            },
            loadingWidget: const BuildOverlay(),
          );
        }

        // // take screenshot
        Uint8List image = await _screenshotController.captureFromWidget(
          BuildInvoicePrintableBody(
            invoice: invoice,
            team: localTeam!,
            client: localClient!,
            hasScroll: false,
            width: double.infinity,
            height: double.infinity,
          ),
          delay: const Duration(milliseconds: 500),
          context: Get.context,
          targetSize: const Size(816, 1056),
          pixelRatio: 3,
        );

        final pdf = pw.Document();
        pw.Image pwImage = pw.Image(pw.MemoryImage(image));
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.zero,
            build: (pw.Context context) {
              return pw.Container(
                child: pwImage,
              );
            },
          ),
        );

        if (isPrint == true) {
          await Printing.layoutPdf(
            onLayout: (format) async => pdf.save(),
          );
          return;
        }

        await _fileManegerProvider.saveFileWithoutLocation(
          fileName:
              'FlutterPP_${localTeam?.name}_invoice_${invoice.number}.pdf',
          fileExtension: 'pdf',
          bytes: await pdf.save(),
        );
      },
      name: 'downloadInvoice',
    );
  }
}
