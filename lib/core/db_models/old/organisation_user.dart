// collection name: organisation_user
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganisationUser {
  String email;
  Map<String, UserOrganisation>
      organisations; // id of map should be an Id of organisation in organisation collection
  Timestamp dateCreated;
}

// helper
class UserOrganisation {
  String status;
  String role;
  String name;
}
