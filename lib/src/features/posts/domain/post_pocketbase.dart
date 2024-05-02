import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/posts/domain/post.dart';
import 'package:openstack/src/features/posts/domain/vote.dart';
import 'package:pocketbase/pocketbase.dart';

part 'post_pocketbase.mapper.dart';

@MappableClass()
class PostPocketBase extends PostModel with PostPocketBaseMappable {
  PostPocketBase({
    @MappableField(key: 'id') String? id,
    @MappableField(key: 'title') String? title,
    @MappableField(key: 'summary') String? summary,
    @MappableField(key: 'image') String? image,
    @MappableField(key: 'author', hook: ReturnNullHook())
    UserPocketBase? author,
    @MappableField(key: 'upVoted') bool upVoted = false,
    @MappableField(key: 'downVoted') bool downVoted = false,
    @MappableField(key: 'bookmarked') bool bookmarked = false,
    @MappableField(key: 'numUpvotes') int numUpVotes = 0,
    @MappableField(key: 'numComments') int numComments = 0,
    @MappableField(key: 'tags') List<String> tags = const [],
  }) : super(
          id: id,
          title: title,
          summary: summary,
          image: image,
          author: author,
          upVoted: upVoted,
          downVoted: downVoted,
          bookmarked: bookmarked,
          numUpVotes: numUpVotes,
          numComments: numComments,
          tags: tags,
        );

  static const fromMap = PostPocketBaseMapper.fromMap;

  static const fromJson = PostPocketBaseMapper.fromJson;

  factory PostPocketBase.fromRecordModel(RecordModel record,
      [String? currentUserId]) {
    final authorRecord = record.expand['author']?.first;
    final numComments = record.expand['comments_via_post']?.length;

    final votes = record.expand['votes_via_post']
        ?.map((e) => VoteModel.fromRecordModel(e));

    final voteUser = votes?.where((e) => e.user == currentUserId).firstOrNull;

    final numUpVotes = votes?.where((e) => e.type == VoteType.up).length;

    return PostPocketBase.fromJson(record.toString()).copyWith(
      author: authorRecord == null
          ? null
          : UserPocketBase.fromRecordModel(authorRecord),
      numComments: numComments,
      numUpVotes: numUpVotes,
      upVoted: voteUser?.type == VoteType.up,
      downVoted: voteUser?.type == VoteType.down,
    );
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
