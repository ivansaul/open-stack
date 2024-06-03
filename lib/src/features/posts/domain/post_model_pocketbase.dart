import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/posts/domain/post_entity.dart';
import 'package:pocketbase/pocketbase.dart';

part 'post_model_pocketbase.mapper.dart';

/// A class representing a PocketBase post model.
///
@MappableClass()
class PostModelPocketBase extends PostEntity with PostModelPocketBaseMappable {
  PostModelPocketBase({
    required String id,
    required String profileId,
    required String title,
    String? summary,
    List<String>? tags,
    String? thumbnailId,
    String? sourceUrl,
  }) : super(
          id: id,
          profileId: profileId,
          title: title,
          summary: summary,
          tags: tags,
          thumbnailId: thumbnailId,
          sourceUrl: sourceUrl,
        );

  // static const fromMap = PostModelPocketBaseMapper.fromMap;

  // static const fromJson = PostModelPocketBaseMapper.fromJson;

  factory PostModelPocketBase.fromRecord(RecordModel record) {
    final id = record.id;
    final profileId = record.getStringValue('profile_id');
    final title = record.getStringValue('title');
    final summary = record.getStringValue('summary');
    final tags = record.getListValue<String>('tags');
    final thumbnailId = record.getStringValue('thumbnail_id');
    final sourceUrl = record.getStringValue('source_url');
    return PostModelPocketBase(
      id: id,
      profileId: profileId,
      title: title,
      summary: summary.isEmpty ? null : summary,
      tags: tags.isEmpty ? null : tags,
      thumbnailId: thumbnailId.isEmpty ? null : thumbnailId,
      sourceUrl: sourceUrl.isEmpty ? null : sourceUrl,
    );
  }
}
