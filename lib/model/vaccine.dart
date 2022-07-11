import 'dart:convert';
import 'package:flutter/foundation.dart';

class Vaccine {
  String name;
  int min;
  int max;

  Vaccine({
    required this.name,
    required this.min,
    required this.max,
  });

  Vaccine copyWith({
    String? name,
    int? min,
    int? max,
  }) {
    return Vaccine(
      name: name ?? this.name,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'min': min,
      'max': max,
    };
  }

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      name: map['name'] as String,
      min: map['min'] as int,
      max: map['max'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccine.fromJson(String source) => Vaccine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Vaccine(name: $name, min: $min, max: $max)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vaccine && other.name == name && other.min == min && other.max == max;
  }

  @override
  int get hashCode => name.hashCode ^ min.hashCode ^ max.hashCode;
}

class Vaccines {
  List<Vaccine> vaccines;
  Vaccines({
    required this.vaccines,
  });

  Vaccines copyWith({
    List<Vaccine>? vaccines,
  }) {
    return Vaccines(
      vaccines: vaccines ?? this.vaccines,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vaccines': vaccines.map((x) => x.toMap()).toList(),
    };
  }

  factory Vaccines.fromMap(Map<String, dynamic> map) {
    return Vaccines(
      vaccines: List<Vaccine>.from(
        (map['vaccines'] as List<dynamic>).map<Vaccine>(
          (x) => Vaccine.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Vaccines.fromJson(String source) => Vaccines.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Vaccines(vaccines: $vaccines)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vaccines && listEquals(other.vaccines, vaccines);
  }

  @override
  int get hashCode => vaccines.hashCode;
}
