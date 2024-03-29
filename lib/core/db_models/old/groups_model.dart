import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/groups_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class Group {
  String groupId;
  String name;
  String billingEmail;

  Group({this.groupId, this.name, this.billingEmail});

  Group.clone(Group group)
      : this(
            groupId: group.groupId,
            name: group.name,
            billingEmail: group.billingEmail);

  factory Group.fromMap(String id, Map map) {
    try {
      if (map != null && map.isNotEmpty) {
        return Group(
          groupId: id,
          name: map[GroupsSchema.name],
          billingEmail: map[GroupsSchema.billingEmail],
        );
      }
      return null;
    } catch (e, s) {
      print("group catch_____${e}____$s");
      return null;
    }
  }
}

class GroupOrgUserRelation {
  DocumentReference groupRef;
  DocumentReference organisationRef;
  DocumentReference organisationUserRef;
  GroupRole groupRole;
  Group group;
  bool canChangeGroupRole;

  GroupOrgUserRelation({
    this.groupRef,
    this.organisationRef,
    this.organisationUserRef,
    this.groupRole,
    this.group,
    this.canChangeGroupRole,
  });

  factory GroupOrgUserRelation.fromMap(Map map) {
    try {
      return GroupOrgUserRelation(
        groupRef: map[GroupsSchema.groupRef],
        organisationRef: map[GroupsSchema.organisationRef],
        organisationUserRef: map[GroupsSchema.organisationUserRef],
        groupRole: EnumHelpers.groupRoleFromString(map[GroupsSchema.groupRole]),
        canChangeGroupRole: map[GroupsSchema.canChangeGroupRole] ?? false,
      );
    } catch (e, s) {
      print('group user relation catch___${e}____$s');
      return null;
    }
  }
}
