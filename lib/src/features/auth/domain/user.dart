import 'package:dart_mappable/dart_mappable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:pocketbase/pocketbase.dart';

part 'user.freezed.dart';
part 'user.g.dart';
part 'user.mapper.dart';

@freezed
class User with _$User {
  factory User({
    required String id,
    required String email,
    required String name,
    required String username,
    String? avatar,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@MappableClass(discriminatorKey: 'type')
abstract class UserModel with UserModelMappable {
  final String? id;
  final String? email;
  final String? name;
  final String? username;
  final String? avatar;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.username,
    this.avatar,
  });

  static const fromMap = UserModelMapper.fromMap;
  static const fromJson = UserModelMapper.fromJson;
}

/// PocketBase User Mapper
///
/// PocketBase always returns empty string if anything is missing
/// It's our responsibility to convert empty string to null
@MappableClass()
class UserPocketBase extends UserModel with UserPocketBaseMappable {
  final String? _collectionName;
  final String? _collectionId;
  UserPocketBase({
    @MappableField(key: 'id') String? id,
    @MappableField(key: 'email', hook: EmptyStringHook()) String? email,
    @MappableField(key: 'name', hook: EmptyStringHook()) String? name,
    @MappableField(key: 'username') String? username,
    @MappableField(key: 'avatar', hook: EmptyStringHook()) String? avatar,
    String? collectionName,
    String? collectionId,
  })  : _collectionId = collectionId,
        _collectionName = collectionName,
        super(
          id: id,
          email: email,
          name: name,
          username: username,
          avatar: avatar,
        );

  static const fromMap = UserPocketBaseMapper.fromMap;

  static const fromJson = UserPocketBaseMapper.fromJson;

  factory UserPocketBase.fromRecordModel(RecordModel record) {
    final user = UserPocketBase.fromJson(record.toString());
    final avatar = user.avatar;
    return user.copyWith(
      avatar: (avatar == null)
          ? null
          : '${Constants.apiBaseUrl}/api/files/${record.collectionName}/${record.id}/$avatar',
    );
  }
}

/// Mapping hook for converting empty string to null
class EmptyStringHook extends MappingHook {
  const EmptyStringHook();

  @override
  Object? beforeDecode(Object? value) {
    if (value == "") {
      return null;
    }
    return value;
  }
}
