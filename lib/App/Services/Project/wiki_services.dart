import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:flutterpp/App/Providers/Network/Project/wiki_provider.dart';
import 'package:flutterpp/App/Services/Global/call_pipeline.dart';

class WikiServices {
  final WikiProvider _wikiProvider = WikiProvider();
  final CallPipeline _callPipeline = CallPipeline();

  // get all wikis by project id
  Future<List<WikiModel>?> getWikis({required String projectId}) async {
    List<WikiModel>? wikis = await _callPipeline.futurePipeline(
      future: () => _wikiProvider.getWikis(projectId: projectId),
      name: 'getWikis',
    );

    return wikis;
  }

  // get wiki by project id
  Future<WikiModel?> getWiki({required int projectId}) async {
    WikiModel? wiki = await _callPipeline.futurePipeline(
      future: () => _wikiProvider.getWiki(projectId: projectId),
      name: 'getWiki',
    );

    return wiki;
  }

  // create wiki
  Future<WikiModel?> createWiki({
    required Map document,
    required String projectId,
    required String title,
  }) async {
    WikiModel? wiki = await _callPipeline.futurePipeline(
      future: () => _wikiProvider.createWiki(
        title: title,
        document: document,
        projectId: projectId,
      ),
      name: 'createWiki',
    );

    return wiki;
  }

  // update wiki
  Future<WikiModel?> updateWiki({required WikiModel wiki}) async {
    WikiModel? updatedWiki = await _callPipeline.futurePipeline(
      future: () => _wikiProvider.updateWiki(wiki: wiki),
      name: 'updateWiki',
    );

    return updatedWiki;
  }

  // defult document
  get getDefultDocument => _wikiProvider.getDefultDocument;
}
