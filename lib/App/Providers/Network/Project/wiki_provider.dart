import 'dart:convert';

import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WikiProvider {
  // supabase
  final supabase = Supabase.instance.client;

  // get all project wikis
  Future<List<WikiModel>?> getWikis({required String projectId}) async {
    List<Map> data = await supabase
        .from('wikis')
        .select('*')
        .eq('project_id', projectId)
        .select();

    if (data.isEmpty) return null;

    List<WikiModel> items = data.map((e) {
      var localJson = json.encode(e);
      return WikiModel.fromJson(json.decode(localJson));
    }).toList();

    return items;
  }

  // get wiki by project id
  Future<WikiModel?> getWiki({required int projectId}) async {
    List<Map> data = await supabase
        .from('wikis')
        .select('*')
        .eq('project_id', projectId)
        .select();

    if (data.isEmpty) return null;

    var localJson = json.encode(data[0]);
    return WikiModel.fromJson(json.decode(localJson));
  }

  // create wiki
  Future<WikiModel?> createWiki({
    required Map document,
    required String projectId,
    required String title,
  }) async {
    List<Map> data = await supabase.from('wikis').insert([
      {
        'title': title,
        'document': document,
        'project_id': projectId,
      }
    ]).select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);

    WikiModel item = WikiModel.fromJson(json.decode(localJson));

    return item;
  }

  // update wiki
  Future<WikiModel?> updateWiki({required WikiModel wiki}) async {
    List<Map> data = await supabase
        .from('wikis')
        .update({
          'document': _defultDocument,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', wiki.id!)
        .select();

    if (data.isEmpty) return null;
    var localJson = json.encode(data[0]);
    return WikiModel.fromJson(json.decode(localJson));
  }

  // defult document
  get getDefultDocument => _defultDocument;
}

final Map _defultDocument = {
  "document": {
    "type": "page",
    "children": [
      {
        "type": "heading",
        "data": {
          "level": 2,
          "delta": [
            {
              "insert": "Welcome to",
              "attributes": {"bold": true}
            },
            {"insert": " your wiki 🖐️"}
          ],
          "align": "left"
        }
      },
      {
        "type": "paragraph",
        "data": {
          "delta": [
            {
              "insert":
                  "Here, you can find the project overview and all the outlines you need to reference periodically."
            }
          ]
        }
      },
      {
        "type": "paragraph",
        "data": {
          "delta": [
            {"insert": "you can always you "},
            {
              "insert": "\" cmd+s or ctrl+s \"",
              "attributes": {"bold": true, "font_color": "0xff2196f3"}
            },
            {"insert": " for quick save!!!"}
          ]
        }
      },
      {"type": "divider"},
      {
        "type": "todo_list",
        "data": {
          "delta": [
            {"insert": "drink some water and take a break"},
          ],
          "checked": false
        }
      },
      {
        "type": "todo_list",
        "data": {
          "delta": [
            {"insert": "crash some code and have fun!"},
          ],
          "checked": false
        }
      },
      {
        "type": "todo_list",
        "data": {
          "delta": [
            {"insert": "write to us we love feedback!"},
          ],
          "checked": false
        }
      },
      {
        "type": "todo_list",
        "data": {
          "delta": [
            {"insert": "we won't say no to 5 stars! on the store 😁"},
          ],
          "checked": false
        }
      }
    ]
  }
};
