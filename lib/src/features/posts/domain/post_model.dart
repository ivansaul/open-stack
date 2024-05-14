import 'package:dart_mappable/dart_mappable.dart';

part 'post_model.mapper.dart';

@MappableClass()
abstract class PostModel with PostModelMappable {
  PostModel({
    required this.id,
    required this.title,
    this.summary,
    this.image,
    required this.profileId,
    this.tags,
  });

  final String id;
  final String title;
  final String? summary;
  final String? image;
  final String profileId;
  final List<String>? tags;

  static const fromMap = PostModelMapper.fromMap;

  static const fromJson = PostModelMapper.fromJson;
}
