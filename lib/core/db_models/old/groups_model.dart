import 'package:fielder_models/core/db_models/old/schema/groups_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class Group {
  String groupId;
  String name;
  GroupRole groupRole;

  Group({this.groupId, this.name, this.groupRole});

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
