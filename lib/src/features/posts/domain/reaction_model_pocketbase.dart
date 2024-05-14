import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';
import 'package:pocketbase/pocketbase.dart';

part 'reaction_model_pocketbase.mapper.dart';

@MappableClass()
class ReactionModelPocketBase extends ReactionModel
    with ReactionModelPocketBaseMappable {
  ReactionModelPocketBase({
    @MappableField(key: 'id') required String id,
    @MappableField(key: 'post_id') required String postId,
    @MappableField(key: 'profile_id') required String profileId,
    @MappableField(key: 'type') required ReactionType type,
  }) : super(
          id: id,
          postId: postId,
          profileId: profileId,
          type: type,
        );

  static const fromMap = ReactionModelPocketBaseMapper.fromMap;

  static const fromJson = ReactionModelPocketBaseMapper.fromJson;

  factory ReactionModelPocketBase.fromRecordModel(RecordModel record) {
    return ReactionModelPocketBase.fromJson(record.toString());
  }
}
