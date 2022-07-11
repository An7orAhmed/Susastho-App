import 'dart:convert';

class VaccineTaken {
  String name;
  String takenDate;
  String status;

  VaccineTaken({
    required this.name,
    required this.takenDate,
    required this.status,
  });

  VaccineTaken copyWith({
    String? name,
    String? takenDate,
    String? status,
  }) {
    return VaccineTaken(
      name: name ?? this.name,
      takenDate: takenDate ?? this.takenDate,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'takenDate': takenDate,
      'status': status,
    };
  }

  factory VaccineTaken.fromMap(Map<String, dynamic> map) {
    return VaccineTaken(
      name: map['name'] as String,
      takenDate: map['takenDate'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VaccineTaken.fromJson(String source) => VaccineTaken.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VaccineTaken(name: $name, takenDate: $takenDate, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VaccineTaken && other.name == name && other.takenDate == takenDate && other.status == status;
  }

  @override
  int get hashCode => name.hashCode ^ takenDate.hashCode ^ status.hashCode;
}
