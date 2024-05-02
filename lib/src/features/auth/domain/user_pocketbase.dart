import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:pocketbase/pocketbase.dart';

part 'user_pocketbase.mapper.dart';

/// PocketBase UserModel Mapper
///
/// PocketBase always returns empty string if anything is missing
/// It's our responsibility to convert empty string to null
@MappableClass()
class UserPocketBase extends UserModel with UserPocketBaseMappable {
  UserPocketBase({
    @MappableField(key: 'id') String? id,
    @MappableField(key: 'email') String? email,
    @MappableField(key: 'name') String? name,
    @MappableField(key: 'username') String? username,
    @MappableField(key: 'avatar') String? avatar,
    String? collectionName,
    String? collectionId,
  }) : super(
          id: id,
          email: email,
          name: name,
          username: username,
          avatar: avatar,
        );

  static const fromMap = UserPocketBaseMapper.fromMap;

  static const fromJson = UserPocketBaseMapper.fromJson;

  factory UserPocketBase.fromRecordModel(RecordModel record) {
    final recordId = record.id;
    final email = record.getStringValue('email');
    final name = record.getStringValue('name');
    final username = record.getStringValue('username');
    final avatar = record.getStringValue('avatar');
    final collectionName = record.collectionName;

    final avatarUrl = avatar.isEmpty
        ? null
        : '${Constants.apiBaseUrl}/api/files/$collectionName/$recordId/$avatar';

    final user = UserPocketBase(
      id: recordId,
      email: email.isEmpty ? null : email,
      name: name.isEmpty ? null : name,
      username: username.isEmpty ? null : username,
      avatar: avatarUrl,
    );
    return user;
  }
}
