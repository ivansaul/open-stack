import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/auth/domain/user.dart';

part 'post.mapper.dart';

@MappableClass()
abstract class PostModel with PostModelMappable {
  final String? id;
  final String? title;
  final String? summary;
  final String? image;
  final UserModel? author;
  final bool upVoted;
  final bool downVoted;
  final bool bookmarked;
  final int numUpVotes;
  final int numComments;
  final List<String> tags;

  PostModel({
    this.id,
    this.title,
    this.summary,
    this.image,
    this.author,
    this.upVoted = false,
    this.downVoted = false,
    this.bookmarked = false,
    this.numUpVotes = 0,
    this.numComments = 0,
    this.tags = const [],
  });

  static const fromMap = PostModelMapper.fromMap;

  static const fromJson = PostModelMapper.fromJson;
}
