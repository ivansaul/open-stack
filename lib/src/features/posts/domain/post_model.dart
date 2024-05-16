import 'package:dart_mappable/dart_mappable.dart';

part 'post_model.mapper.dart';

/// A class representing a post model.
///
@MappableClass()
class PostModel with PostModelMappable {
  PostModel({
    @MappableField(key: 'id') required this.id,
    @MappableField(key: 'title') required this.title,
    @MappableField(key: 'summary') this.summary,
    @MappableField(key: 'profile_id') required this.profileId,
    @MappableField(key: 'tags') this.tags,
    @MappableField(key: 'thumbnail') this.thumbnail,
    @MappableField(key: 'source_url') this.sourceUrl,
  });

  /// Unique identifier of the post.
  final String id;

  /// The title of the post.
  final String title;

  /// The summary of the post.
  final String? summary;

  /// The identifier of the user who created the post.
  final String profileId;

  /// A list of tags associated with the post.
  final List<String>? tags;

  /// The name of the thumbnail image for the post.
  final String? thumbnail;

  /// The source URL of the post.
  final String? sourceUrl;

  /// Creates an instance of `PostModel` from a map.
  static const fromMap = PostModelMapper.fromMap;

  /// Creates an instance of `PostModel` from JSON.
  static const fromJson = PostModelMapper.fromJson;
}
