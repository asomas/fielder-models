import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/helpers/enum_helpers.dart';
import 'package:fielder_models/core/db_models/old/schema/on_boarding_doc_schema.dart';
import 'package:fielder_models/core/enums/enums.dart';

class OnBoardingDocumentModel {
  String id;
  String title;
  String docPath;
  DateTime uploadDate;
  OnBoardingDocumentSignStatus status;

  OnBoardingDocumentModel(
      {this.id, this.title, this.docPath, this.uploadDate, this.status});

  factory OnBoardingDocumentModel.fromMap(Map map, {String id}) {
    if (map != null && map.isNotEmpty) {
      try {
        dynamic _uploadDate;
        _uploadDate = map[OnBoardingDocumentSchema.uploadDate];
        if (_uploadDate != null && _uploadDate is String) {
          String split = _uploadDate.toString().split("T")[0];
          _uploadDate = Timestamp.fromDate(DateTime.parse(split));
        }
        return OnBoardingDocumentModel(
          id: id ?? map[OnBoardingDocumentSchema.id],
          title: map[OnBoardingDocumentSchema.title],
          uploadDate: _uploadDate?.toDate(),
          docPath: map[OnBoardingDocumentSchema.filePath],
          status: EnumHelpers.onBoardingDocumentSignStatusFromString(
            map[OnBoardingDocumentSchema.status],
          ),
        );
      } catch (e, s) {
        print("Onboardng signed status model catch____${e}___$s");
        return null;
      }
    } else {
      return null;
    }
  }
}
