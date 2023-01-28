import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String id;
  final String title;
  final String date;
  final String description;
  final String image;

  const Event(this.id, this.title, this.date, this.description, this.image);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
