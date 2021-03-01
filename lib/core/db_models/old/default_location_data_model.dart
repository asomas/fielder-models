import 'package:fielder_models/core/db_models/old/address_model.dart';
import 'package:fielder_models/core/db_models/old/coordinates_data_model.dart';
import 'package:fielder_models/core/db_models/schema/default_location_data_schema.dart';

class DefaultLocationDataModel {
  final CoordinatesModel coordinates;
  final AddressModel address;

  DefaultLocationDataModel({
    this.address,
    this.coordinates,
  });


  Map<String, dynamic> toJSON() {
    return {
      DefaultLocationDataSchema.address: address.toJSON(),
      DefaultLocationDataSchema.coordinates: coordinates.toJSON(),
    };
  }
}
