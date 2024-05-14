import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:pocketbase/pocketbase.dart';

part 'post_model_pocketbase.mapper.dart';

@MappableClass()
class PostModelPocketBase extends PostModel with PostModelPocketBaseMappable {
  PostModelPocketBase({
    @MappableField(key: 'id') required String id,
    @MappableField(key: 'title') required String title,
    @MappableField(key: 'summary') String? summary,
    @MappableField(key: 'image') String? image,
    @MappableField(key: 'profile_id') required String profileId,
    @MappableField(key: 'tags') List<String>? tags,
  }) : super(
          id: id,
          title: title,
          summary: summary,
          profileId: profileId,
          image: image,
          tags: tags,
        );

  static const fromMap = PostModelPocketBaseMapper.fromMap;

  static const fromJson = PostModelPocketBaseMapper.fromJson;

  factory PostModelPocketBase.fromRecordModel(RecordModel record) {
    return PostModelPocketBase.fromJson(record.toString());
  }
}

/// This Hook return null
class ReturnNullHook extends MappingHook {
  const ReturnNullHook();

  @override
  Object? beforeDecode(Object? value) {
    return null;
  }
}
