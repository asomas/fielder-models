import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fielder_models/core/db_models/old/checks_model.dart';
import 'package:fielder_models/core/db_models/old/qualification_model.dart';
import 'package:fielder_models/core/db_models/old/skills_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/old/schema/job_summary_schema.dart';
import 'package:fielder_models/core/db_models/old/workers_model.dart';
import 'job_location_data_model.dart';

class JobDataModel {
  String docID;
  bool active;
  String jobTitle;
  DateTime startDate;
  DateTime endDate;
  double totalHours;
  int totalShiftsCount;
  int rate;
  String payCalculation;
  List<SkillsModel> skills;
  List<QualificationModel> qualifications;
  List<CheckModel> checks;
  List<String> issuesArray;
  List<WorkerModel> workersArray;
  List<JobLocationDataModel> locationsArray;
  DocumentReference organisationRef;
  DocumentReference supervisorRef;
  DocumentReference managerRef;
  int earlyLeaver;
  bool isPayDeductionEnabled;
  int lateArrival;
  double overTimeRate;

  JobDataModel({
    this.docID,
    this.active,
    this.jobTitle,
    this.startDate,
    this.endDate,
    this.totalHours,
    this.issuesArray,
    this.workersArray,
    this.locationsArray,
    this.rate,
    this.payCalculation,
    this.skills,
    this.qualifications,
    this.checks,
    this.organisationRef,
    this.supervisorRef,
    this.managerRef,
    this.totalShiftsCount = 0,
    this.earlyLeaver,
    this.isPayDeductionEnabled,
    this.lateArrival,
    this.overTimeRate
  }) : assert(docID != null);

  factory JobDataModel.fromMap({
    @required Map<String, dynamic> map,
    @required String docID,
  }) {
    if (map.isNotEmpty) {
      try {
        DocumentReference _organisationRef = map[JobSummarySchema.organisationRef];
        DocumentReference _supervisorRef = map[JobSummarySchema.supervisorRef];
        DocumentReference _managerRef = map[JobSummarySchema.managerRef];
        final double _overTimeRate = map[JobSummarySchema.overTimeRate] != null
              ? (map[JobSummarySchema.overTimeRate] / 100) : 0;
        final int _earlyLeaver = map[JobSummarySchema.earlyLeaver] != null ?
            map[JobSummarySchema.earlyLeaver] : 0;
        final int _lateArrival = map[JobSummarySchema.lateArrival] != null?
        map[JobSummarySchema.lateArrival] : 0;
        final bool _isPayDeductionEnabled =
            map[JobSummarySchema.enablePayDeduction] ?? false;
        final Timestamp _startTimeStamp = map[JobSummarySchema.startDate];
        DateTime _startDate;
        if (_startTimeStamp != null) {
          _startDate = DateTime.fromMillisecondsSinceEpoch(
            _startTimeStamp.millisecondsSinceEpoch,
          );
        }
        final Timestamp _endTimeStamp = map[JobSummarySchema.endDate];
        DateTime _endDate;
        if (_endTimeStamp != null) {
          _endDate = DateTime.fromMillisecondsSinceEpoch(
            _endTimeStamp.millisecondsSinceEpoch,
          );
        }
        final bool _active = map[JobSummarySchema.active] ?? false;
        final String _jobTitle = map[JobSummarySchema.jobTitle] ?? '';
        final double _totalHours = map[JobSummarySchema.totalHours] ?? 0;
        final int _rate = map[JobSummarySchema.rate] ?? 0;
        final String _payCalculation =
            map[JobSummarySchema.payCalculation] ?? "";
        final Map<String, dynamic> workers =
            map[JobSummarySchema.workers] ?? {};
        List<WorkerModel> _allWorkerArray = [];
        workers.forEach((key, element) {
          final WorkerModel _worker = WorkerModel.fromMap(
            map: element,
            docID: key,
          );

          if (_worker != null) {
            _allWorkerArray.add(_worker);
          }
        });

        final Map<String, dynamic> locations =
            map[JobSummarySchema.locations] ?? {};
        List<JobLocationDataModel> _allLocationArray = [];
        locations.forEach((key, element) {
          final JobLocationDataModel _location = JobLocationDataModel.fromMap(
            map: element,
            docID: key,
          );

          if (_location != null) {
            _allLocationArray.add(_location);
          }
        });

        final List<dynamic> issues = map[JobSummarySchema.issues] ?? [];
        List<String> _allIssuesArray = [];
        issues.forEach((element) {
          if (element != null) {
            _allIssuesArray.add(element);
          }
        });

        final List<SkillsModel> _skills = (map[JobSummarySchema.skills] as List)?.isNotEmpty == true
            ? (map[JobSummarySchema.skills] as List)
            .map((e) => SkillsModel.fromMap(
            map: e, docID: e[JobSummarySchema.skillRef]?.id))
            .toList()
            : [];

        final List<QualificationModel> _qualifications = (map[JobSummarySchema.qualification] as List)?.isNotEmpty == true
            ? (map[JobSummarySchema.qualification] as List)
            .map((e) => QualificationModel.fromMap(
            map: e, docID: e[JobSummarySchema.qualificationRef]?.id))
            .toList()
            : [];

        final List<CheckModel> _checks = (map[JobSummarySchema.checks] as List)?.isNotEmpty == true
            ? (map[JobSummarySchema.checks] as List)
            .map((e) => CheckModel.fromMap(
            map: e, checkID: e[JobSummarySchema.checkRef]?.id))
            .toList()
            : [];

        return JobDataModel(
            docID: docID,
            startDate: _startDate,
            endDate: _endDate,
            active: _active,
            totalHours: _totalHours,
            jobTitle: _jobTitle,
            workersArray: _allWorkerArray,
            locationsArray: _allLocationArray,
            issuesArray: _allIssuesArray,
            checks: _checks,
            skills: _skills,
            qualifications: _qualifications,
            rate: _rate,
            payCalculation: _payCalculation,
            totalShiftsCount: map[JobSummarySchema.totalShiftsCount],
            organisationRef: _organisationRef,
            supervisorRef: _supervisorRef,
            managerRef: _managerRef,
            overTimeRate: _overTimeRate,
            earlyLeaver: _earlyLeaver,
            lateArrival: _lateArrival,
            isPayDeductionEnabled: _isPayDeductionEnabled
        );
      } catch (e) {
        print('JobDataModel fromMap error: $e');
      }
    }
    return null;
  }
}
