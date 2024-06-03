class PostEntity {
  PostEntity({
    required this.id,
    required this.profileId,
    required this.title,
    this.summary,
    this.tags,
    this.thumbnailId,
    this.sourceUrl,
  });

  /// Unique identifier of the post.
  final String id;

  /// The identifier of the user who created the post.
  final String profileId;

  /// The title of the post.
  final String title;

  /// The summary of the post.
  final String? summary;

  /// A list of tags associated with the post.
  final List<String>? tags;

  /// The name of the thumbnail image for the post.
  final String? thumbnailId;

  /// The source URL of the post.
  final String? sourceUrl;
}
