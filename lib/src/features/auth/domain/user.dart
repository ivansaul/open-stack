import 'package:dart_mappable/dart_mappable.dart';

part 'user.mapper.dart';

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
