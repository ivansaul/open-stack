import 'package:dart_mappable/dart_mappable.dart';

part 'reaction_model.mapper.dart';

@MappableEnum()
enum ReactionType {
  up,
  down,
}

@MappableClass()
class ReactionModel with ReactionModelMappable {
  ReactionModel({
    required this.id,
    required this.postId,
    required this.profileId,
    required this.type,
  });

  final String id;
  final String postId;
  final String profileId;
  final ReactionType type;

  static const fromMap = ReactionModelMapper.fromMap;

  static const fromJson = ReactionModelMapper.fromJson;
}
