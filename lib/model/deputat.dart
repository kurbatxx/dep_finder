// "deputat_id": 1,
// "deputat_name": "Name",
// "uch_number": 1

import 'package:dart_mappable/dart_mappable.dart';

part 'deputat.mapper.dart';

@MappableClass()
class Deputat with DeputatMappable {
  final int deputatId;
  final String deputatName;
  final int uchNumber;

  Deputat({
    @MappableField(key: 'deputat_id') required this.deputatId,
    @MappableField(key: 'deputat_name') required this.deputatName,
    @MappableField(key: 'uch_number') required this.uchNumber,
  });

  static const fromMap = DeputatMapper.fromMap;
}
