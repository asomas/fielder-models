import 'package:fielder_models/core/db_models/old/slot_model.dart';
import 'package:flutter/cupertino.dart';

class DateAndSlotsModel {
  final DateTime dt;
  final List<SlotModel> slots;
  bool disabled;
  int totalTimeRows;

  DateAndSlotsModel(
      {@required this.dt,
      this.slots,
      this.disabled = false,
      this.totalTimeRows = 1});
}
