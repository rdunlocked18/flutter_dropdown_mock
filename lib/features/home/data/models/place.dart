import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final int? id;
  final String? value;

  const Place({
    this.id,
    this.value,
  });

  Place.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        value = json['value'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
      };

  @override
  List<Object?> get props => [id, value];
}
