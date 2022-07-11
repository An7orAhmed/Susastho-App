import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:susastho/model/vaccine_taken.dart';

class AppUser {
  String name;
  String email;
  String address;
  String phone;
  String nid;
  int age;
  String blood;
  String type;
  List<VaccineTaken> vaccineTaken;

  AppUser({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.nid,
    required this.age,
    required this.blood,
    required this.type,
    required this.vaccineTaken,
  });

  AppUser copyWith({
    String? name,
    String? email,
    String? address,
    String? phone,
    String? nid,
    int? age,
    String? blood,
    String? type,
    List<VaccineTaken>? vaccineTaken,
  }) {
    return AppUser(
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      nid: nid ?? this.nid,
      age: age ?? this.age,
      blood: blood ?? this.blood,
      type: type ?? this.type,
      vaccineTaken: vaccineTaken ?? this.vaccineTaken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'nid': nid,
      'age': age,
      'blood': blood,
      'type': type,
      'vaccineTaken': vaccineTaken.map((x) => x.toMap()).toList(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      nid: map['nid'] as String,
      age: map['age'] as int,
      blood: map['blood'] as String,
      type: map['type'] as String,
      vaccineTaken: List<VaccineTaken>.from(
        (map['vaccineTaken'] as List<dynamic>).map<VaccineTaken>(
          (x) => VaccineTaken.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(name: $name, email: $email, address: $address, phone: $phone, nid: $nid, age: $age, blood: $blood, type: $type, vaccineTaken: $vaccineTaken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.name == name &&
        other.email == email &&
        other.address == address &&
        other.phone == phone &&
        other.nid == nid &&
        other.age == age &&
        other.blood == blood &&
        other.type == type &&
        listEquals(other.vaccineTaken, vaccineTaken);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        nid.hashCode ^
        age.hashCode ^
        blood.hashCode ^
        type.hashCode ^
        vaccineTaken.hashCode;
  }
}
