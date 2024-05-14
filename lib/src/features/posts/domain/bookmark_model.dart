import 'package:dart_mappable/dart_mappable.dart';

part 'bookmark_model.mapper.dart';

@MappableClass()
class BookmarkModel with BookmarkModelMappable {
  BookmarkModel({
    required this.id,
    @MappableField(key: 'profile_id') required this.profileId,
    @MappableField(key: 'post_id') required this.postId,
  });

  final String id;
  final String profileId;
  final String postId;

  static const fromMap = BookmarkModelMapper.fromMap;
  static const fromJson = BookmarkModelMapper.fromJson;
}
