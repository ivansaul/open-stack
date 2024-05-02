import 'package:dart_mappable/dart_mappable.dart';
import 'package:pocketbase/pocketbase.dart';

part 'vote.mapper.dart';

@MappableEnum()
enum VoteType {
  up,
  down,
}

@MappableClass()
class VoteModel with VoteModelMappable {
  final String? id;
  final String post;
  final String user;
  final VoteType type;

  VoteModel({
    this.id,
    required this.post,
    required this.user,
    required this.type,
  });

  static const fromMap = VoteModelMapper.fromMap;

  static const fromJson = VoteModelMapper.fromJson;

  factory VoteModel.fromRecordModel(RecordModel record) {
    return VoteModel.fromJson(record.toString());
  }
}
