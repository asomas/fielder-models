import 'package:fielder_models/core/db_models/old/schema/organisation_profile_schema.dart';

class OrganisationProfileModel {
  String title;
  String text;
  String docId;

  OrganisationProfileModel({this.title, this.text, this.docId});

  factory OrganisationProfileModel.fromMap(Map map, String docId) {
    try {
      return OrganisationProfileModel(
        docId: docId,
        title: map[OrganisationProfileSchema.title],
        text: map[OrganisationProfileSchema.text],
      );
    } catch (e, s) {
      print("organisation profile model catch____${e}______$s");
      return null;
    }
  }
}
