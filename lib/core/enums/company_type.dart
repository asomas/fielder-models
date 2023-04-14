import 'package:fielder_models/core/extensions/string_extension.dart';

enum CompanyType {
  business,
  recruiter,
  charity,
  enterprise,
}

extension CompanyTypeExt on CompanyType {
  String get label => this.name.capitalizeFirstLetter;
  String get value => this.name;
}
