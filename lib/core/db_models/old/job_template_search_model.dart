

class JobSearchTemplate {
  final num limit;
  final List<EmployerJobTemplate> employerJobTemplate;
  final List<FielderJobTemplate> fielderJobTemplate;

  JobSearchTemplate({this.limit, this.employerJobTemplate, this.fielderJobTemplate});

  factory JobSearchTemplate.fromMap(Map<String, dynamic> map){
    JobSearchTemplate temp;
    try{
      temp = JobSearchTemplate(
                limit: map["employer_templates"]!= null ? map["employer_templates"]["limit"] : 10,
                employerJobTemplate: map["employer_templates"]!= null ? 
                                    _getEmployerJobTemplate(map["employer_templates"]["hits"]) : [],
                fielderJobTemplate: map["fielder_templates"]!= null ?
                                    _getFielderJobTemplate(map["fielder_templates"]["hits"]) : []
           );
     return temp;
    }catch(e){
      print("template error: $e");
      return null;
    }
  }

  static List<EmployerJobTemplate> _getEmployerJobTemplate(List hits){
    List<EmployerJobTemplate> list = [];
    hits.forEach((element) {
      list =  (hits).map((model)=> EmployerJobTemplate.fromMap(model)).toList();
    });
    return list;
  }

  static List<FielderJobTemplate> _getFielderJobTemplate(List hits){
    List<FielderJobTemplate> list = [];
    hits.forEach((element) {
      list =  (hits).map((model)=> FielderJobTemplate.fromMap(model)).toList();
    });
    return list;
  }
}

class EmployerJobTemplate {

  final String employerTemplateID;
  final String employerTemplateName;
  final String employerID;

  EmployerJobTemplate({
    this.employerTemplateID,
    this.employerTemplateName,
    this.employerID,
  });

  factory EmployerJobTemplate.fromMap(Map<String, dynamic> map){
    return EmployerJobTemplate(
      employerTemplateID: map["employer_template_id"] ?? "",
      employerTemplateName: map["name"] ?? "",
      employerID: map["employer_id"] ?? ""
    );
  }

}


class FielderJobTemplate {

  final String fielderTemplateID;
  final String fielderTemplateName;

  FielderJobTemplate({
    this.fielderTemplateID,
    this.fielderTemplateName,
  });

  factory FielderJobTemplate.fromMap(Map<String, dynamic> map){
    return FielderJobTemplate(
        fielderTemplateID : map["fielder_template_id"] ?? "",
        fielderTemplateName : map["name"] ?? "",
    );
  }
}
