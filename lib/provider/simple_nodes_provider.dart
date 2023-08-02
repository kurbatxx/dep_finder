import 'dart:convert';
import 'package:collection/collection.dart' show compareNatural;

import 'package:dep_finder/model/simple_node.dart';
import 'package:dep_finder/provider/ip_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final simpleNodesProvider =
    FutureProvider.family<List<SimpleNode>, int>((ref, parrentId) async {
  //await Future.delayed(const Duration(milliseconds: 300));

  final url = Uri.http(ref.read(ipProvider), '/get_simple_nodes/$parrentId');
  final response = await http.get(url);

  // List<SimpleNode> jsonList = SimpleNodeMapper.fromJson(
  //   json.decode(
  //     utf8.decode(response.bodyBytes),
  //   ),
  // ) as List<SimpleNode>;

  List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes)) as List;
  List<SimpleNode> elements =
      jsonList.map((e) => SimpleNodeMapper.fromMap(e)).toList();

  elements.sort((a, b) => compareNatural(a.nodeName, b.nodeName));
  return elements;
});
