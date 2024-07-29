import 'package:json_annotation/json_annotation.dart';
part 'location_data.g.dart';

@JsonSerializable()
class LocationData {
  final double latitude;
  final double longitude;

  LocationData({
    required this.latitude,
    required this.longitude,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => _$LocationDataFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDataToJson(this);
}
