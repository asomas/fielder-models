import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/budget_model.dart';
import 'package:fielder_models/core/db_models/old/schema/job_template_schema.dart';

class BudgetProfileModel {
  String id;
  String name;
  DocumentReference groupRef;
  DocumentReference jobTemplateRef;
  BudgetModel budgetModel;

  BudgetProfileModel({
    this.id,
    this.name,
    this.groupRef,
    this.budgetModel,
    this.jobTemplateRef,
  });

  factory BudgetProfileModel.fromMap(String id, Map map) {
    if (map != null && map.isNotEmpty) {
      try {
        return BudgetProfileModel(
          id: id,
          name: map[JobTemplateSchema.name],
          groupRef: map[JobTemplateSchema.groupRef],
          jobTemplateRef: map[JobTemplateSchema.jobTemplateRef],
          budgetModel: BudgetModel.fromMap(map),
        );
      } catch (e, s) {
        print("budget profile catch____${e}____$s");
        return null;
      }
    } else {
      return null;
    }
  }
}
