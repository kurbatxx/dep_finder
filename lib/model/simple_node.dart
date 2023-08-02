import 'package:dart_mappable/dart_mappable.dart';

part 'simple_node.mapper.dart';

@MappableClass()
class SimpleNode with SimpleNodeMappable {
  final int nodeId;
  final int parrentId;
  final String nodeName;
  final int? deputatId;

  SimpleNode({
    @MappableField(key: 'node_id') required this.nodeId,
    @MappableField(key: 'parrent_id') required this.parrentId,
    @MappableField(key: 'node_name') required this.nodeName,
    @MappableField(key: 'deputat_id') required this.deputatId,
  });

  static const fromMap = SimpleNodeMapper.fromMap;
  //static const fromJson = SimpleNodeMapper.fromJson;
}
