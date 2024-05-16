class Place {
  final int? id;
  final String? value;

  Place({
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
}
