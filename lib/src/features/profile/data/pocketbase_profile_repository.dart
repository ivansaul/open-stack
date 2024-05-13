import 'package:fpdart/fpdart.dart';
import 'package:openstack/src/constants/typedef.dart';
import 'package:openstack/src/exceptions/app_exceptions.dart';
import 'package:openstack/src/features/auth/domain/user_pocketbase.dart';
import 'package:openstack/src/features/profile/data/profile_repository.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseProfileRepository implements ProfileRepository {
  PocketBaseProfileRepository(this._pb);

  final PocketBase _pb;

  @override
  EitherProfile fetchProfile(UserId userId) async {
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
  EitherProfile updateProfile({
    required UserId userId,
    required BodyMap body,
  }) async {
    try {
      final record = await _pb.collection('users').update(
            userId,
            body: body,
          );
      final user = UserPocketBase.fromRecordModel(record);
      return Right(user);
    } catch (e) {
      // TODO: handle errors
      return const Left(ExceptionProfile.unknown);
    }
  }
}
