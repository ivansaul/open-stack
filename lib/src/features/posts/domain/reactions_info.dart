import 'package:dart_mappable/dart_mappable.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';

part 'reactions_info.mapper.dart';

@MappableClass()
class ReactionsInfo with ReactionsInfoMappable {
  ReactionsInfo({
    this.type,
    this.numUpVotes = 0,
  });

  final ReactionType? type;
  final int numUpVotes;
}
