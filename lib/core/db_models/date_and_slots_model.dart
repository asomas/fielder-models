import 'package:flutter/cupertino.dart';
import 'package:fielder_models/core/db_models/slot_model.dart';

class DateAndSlotsModel {
  final DateTime dt;
  final List<SlotModel> slots;

  DateAndSlotsModel({
    @required this.dt,
    this.slots,
  });
}
