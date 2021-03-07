// collection name: employer_user
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployerUser {
  String email;
  Map<String, UserOrganisation> organisations; // id of map should be an Id of employer in employer collection
  Timestamp dateCreated;
}

// helper
class UserOrganisation {
  String status;
  String role;
  String name;
}
