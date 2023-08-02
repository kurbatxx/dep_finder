import 'dart:convert';

import 'package:dep_finder/model/deputat.dart';
import 'package:dep_finder/provider/ip_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final deputatProvider = FutureProvider.family<Deputat, int>((ref, id) async {
  //await Future.delayed(const Duration(milliseconds: 300));

  final url = Uri.http(ref.read(ipProvider), '/get_deputat/$id');
  final response = await http.get(url);

  // List<SimpleNode> jsonList = SimpleNodeMapper.fromJson(
  //   json.decode(
  //     utf8.decode(response.bodyBytes),
  //   ),
  // ) as List<SimpleNode>;

  dynamic jsonValue = json.decode(utf8.decode(response.bodyBytes));
  //Deputat element = jsonValue.map((e) => DeputatMapper.fromMap(e));
  Deputat element = DeputatMapper.fromMap(jsonValue);

  return element;
});
