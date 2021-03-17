class UserPermissions {
  String name;
  bool owner;
  bool admin;
  bool hr;
  bool manager;
  bool supervisor;

  UserPermissions(
      {this.name,
      this.owner,
      this.admin,
      this.hr,
      this.manager,
      this.supervisor});
}
