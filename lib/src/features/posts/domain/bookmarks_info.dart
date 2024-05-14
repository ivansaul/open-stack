import 'package:dart_mappable/dart_mappable.dart';

part 'bookmarks_info.mapper.dart';

@MappableClass()
class BookmarksInfo with BookmarksInfoMappable {
  BookmarksInfo({
    this.isBookmarked = false,
  });

  final bool isBookmarked;
}
