class JobSearchTemplate {
  final num limit;
  final List<OrganisationJobTemplate> organisationJobTemplate;
  final List<FielderJobTemplate> fielderJobTemplate;

  JobSearchTemplate({this.limit, this.organisationJobTemplate, this.fielderJobTemplate});

  factory JobSearchTemplate.fromMap(Map<String, dynamic> map) {
    JobSearchTemplate temp;
    try {
      var _limit = map["organisation_templates"] != null ? map["organisation_templates"]["limit"] : 10;
      temp = JobSearchTemplate(
          limit: _limit is String ? int.tryParse(_limit) : _limit,
          organisationJobTemplate: map["organisation_templates"] != null
              ? _getOrganisationJobTemplate(map["organisation_templates"]["hits"])
              : [],
          fielderJobTemplate: map["fielder_templates"] != null && !(map["fielder_templates"] is List)
              ? _getFielderJobTemplate(map["fielder_templates"]["hits"])
              : []);
      return temp;
    } catch (e, s) {
      print("template error: ${e}_________$s");
      return null;
    }
  }

  static List<OrganisationJobTemplate> _getOrganisationJobTemplate(List hits) {
    List<OrganisationJobTemplate> list = [];
    hits.forEach((element) {
      list = (hits).map((model) => OrganisationJobTemplate.fromMap(model)).toList();
    });
    return list;
  }

  static List<FielderJobTemplate> _getFielderJobTemplate(List hits) {
    List<FielderJobTemplate> list = [];
    hits.forEach((element) {
      list = (hits).map((model) => FielderJobTemplate.fromMap(model)).toList();
    });
    return list;
  }
}

abstract class RoleTemplate {
  final String templateId;
  final String name;

  RoleTemplate({this.templateId, this.name});
}

class OrganisationJobTemplate extends RoleTemplate {
  final String organisationTemplateID;
  final String organisationTemplateName;
  final String organisationID;

  OrganisationJobTemplate({
    this.organisationTemplateID,
    this.organisationTemplateName,
    this.organisationID,
  }) : super(
          templateId: organisationTemplateID,
          name: organisationTemplateName,
        );

  factory OrganisationJobTemplate.fromMap(Map<String, dynamic> map) {
    return OrganisationJobTemplate(
        organisationTemplateID: map["organisation_template_id"] ?? "",
        organisationTemplateName: map["name"] ?? "",
        organisationID: map["organisation_id"] ?? "");
  }
}

class FielderJobTemplate extends RoleTemplate {
  final String fielderTemplateID;
  final String fielderTemplateName;

  FielderJobTemplate({
    this.fielderTemplateID,
    this.fielderTemplateName,
  }) : super(
          templateId: fielderTemplateID,
          name: fielderTemplateName,
        );

  factory FielderJobTemplate.fromMap(Map<String, dynamic> map) {
    return FielderJobTemplate(
      fielderTemplateID: map["fielder_template_id"] ?? "",
      fielderTemplateName: map["name"] ?? "",
    );
  }
}
