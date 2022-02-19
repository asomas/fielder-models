import 'package:fielder_models/core/db_models/old/schema/groups_schema.dart';

class Group {
  String groupId;
  String name;

  Group({this.groupId, this.name});

  factory Group.fromMap(String id, Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return Group(
          groupId: id,
          name: map[GroupsSchema.name],
        );
      }
      return null;
    } catch (e, s) {
      print("group catch_____${e}____$s");
      return null;
    }
  }
}
