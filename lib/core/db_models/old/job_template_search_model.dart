class JobSearchTemplate {
  final num limit;
  final List<OrganisationJobTemplate> organisationJobTemplate;
  final List<FielderJobTemplate> fielderJobTemplate;

  JobSearchTemplate(
      {this.limit, this.organisationJobTemplate, this.fielderJobTemplate});

  factory JobSearchTemplate.fromMap(Map<String, dynamic> map) {
    JobSearchTemplate temp;
    try {
      temp = JobSearchTemplate(
          limit: map["organisation_templates"] != null
              ? map["organisation_templates"]["limit"]
              : 10,
          organisationJobTemplate: map["organisation_templates"] != null
              ? _getOrganisationJobTemplate(
                  map["organisation_templates"]["hits"])
              : [],
          fielderJobTemplate: map["fielder_templates"] != null
              ? _getFielderJobTemplate(map["fielder_templates"]["hits"])
              : []);
      return temp;
    } catch (e) {
      print("template error: $e");
      return null;
    }
  }

  static List<OrganisationJobTemplate> _getOrganisationJobTemplate(List hits) {
    List<OrganisationJobTemplate> list = [];
    hits.forEach((element) {
      list = (hits)
          .map((model) => OrganisationJobTemplate.fromMap(model))
          .toList();
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

class OrganisationJobTemplate {
  final String organisationTemplateID;
  final String organisationTemplateName;
  final String organisationID;

  OrganisationJobTemplate({
    this.organisationTemplateID,
    this.organisationTemplateName,
    this.organisationID,
  });

  factory OrganisationJobTemplate.fromMap(Map<String, dynamic> map) {
    return OrganisationJobTemplate(
        organisationTemplateID: map["organisation_template_id"] ?? "",
        organisationTemplateName: map["name"] ?? "",
        organisationID: map["organisation_id"] ?? "");
  }
}

class FielderJobTemplate {
  final String fielderTemplateID;
  final String fielderTemplateName;

  FielderJobTemplate({
    this.fielderTemplateID,
    this.fielderTemplateName,
  });

  factory FielderJobTemplate.fromMap(Map<String, dynamic> map) {
    return FielderJobTemplate(
      fielderTemplateID: map["fielder_template_id"] ?? "",
      fielderTemplateName: map["name"] ?? "",
    );
  }
}
