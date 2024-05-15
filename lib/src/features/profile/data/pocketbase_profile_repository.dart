import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/constants/typedef.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/auth/domain/user_pocketbase.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:openstack/src/features/posts/domain/post_model_pocketbase.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';
import 'package:openstack/src/features/profile/data/profile_repository.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseProfileRepository implements ProfileRepository {
  PocketBaseProfileRepository(this._pb);

  final PocketBase _pb;

  String? get _userId => _pb.authStore.model.id;

  @override
  EitherProfile<UserModel> fetchProfile(UserId userId) async {
    try {
      final record = await _pb.collection('users').getOne(
            userId,
          );
      final user = UserPocketBase.fromRecordModel(record);
      return Right(user);
    } catch (e) {
      // TODO: handle errors
      return const Left(ExceptionProfile.unknown);
    }
  }

  @override
  EitherProfile<UserModel> updateProfile({
    required UserId profileId,
    required BodyMap body,
  }) async {
    try {
      final record = await _pb.collection('users').update(
            profileId,
            body: body,
          );
      final user = UserPocketBase.fromRecordModel(record);
      return Right(user);
    } catch (e) {
      // TODO: handle errors
      return const Left(ExceptionProfile.unknown);
    }
  }

  @override
  EitherProfile<List<PostModel>> fetchMyPosts() async {
    try {
      final records = await _pb.collection('posts').getFullList(
            sort: '-created',
            filter: 'profile_id="$_userId"',
          );

      final posts = records
          .map((record) => PostModelPocketBase.fromRecordModel(record))
          .toList();

      return Right(posts);
    } catch (e) {
      return const Left(ExceptionProfile.unknown);
    }
  }

  @override
  EitherProfile<List<PostModel>> fetchMyUpVotedPosts() async {
    try {
      final records = await _pb.collection('reactions').getFullList(
            sort: '-created',
            filter: 'profile_id="$_userId" && type="${ReactionType.up.name}"',
            expand: 'post_id',
          );

      if (records.isEmpty) {
        return const Right([]);
      }

      final posts = records.map((record) {
        final postRecord = record.expand['post_id']!.first;
        return PostModelPocketBase.fromRecordModel(postRecord);
      }).toList();

      return Right(posts);
    } catch (e) {
      return const Left(ExceptionProfile.unknown);
    }
  }

  @override
  EitherProfile<List<PostModel>> fetchMyBookmarkedPosts() async {
    try {
      final records = await _pb.collection('bookmarks').getFullList(
            sort: '-created',
            filter: 'profile_id="$_userId"',
            expand: 'post_id',
          );

      if (records.isEmpty) {
        return const Right([]);
      }

      final posts = records.map((record) {
        final postRecord = record.expand['post_id']!.first;
        return PostModelPocketBase.fromRecordModel(postRecord);
      }).toList();

      return Right(posts);
    } catch (e) {
      return const Left(ExceptionProfile.unknown);
    }
  }
}
