import 'dart:convert';

class AppUser {
  String name;
  String address;
  String phone;
  String nid;
  int age;
  String blood;
  String type;
  AppUser({
    required this.name,
    required this.address,
    required this.phone,
    required this.nid,
    required this.age,
    required this.blood,
    required this.type,
  });

  AppUser copyWith({
    String? name,
    String? address,
    String? phone,
    String? nid,
    int? age,
    String? blood,
    String? type,
  }) {
    return AppUser(
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      nid: nid ?? this.nid,
      age: age ?? this.age,
      blood: blood ?? this.blood,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'phone': phone,
      'nid': nid,
      'age': age,
      'blood': blood,
      'type': type,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      nid: map['nid'] as String,
      age: map['age'] as int,
      blood: map['blood'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(name: $name, address: $address, phone: $phone, nid: $nid, age: $age, blood: $blood, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.name == name &&
        other.address == address &&
        other.phone == phone &&
        other.nid == nid &&
        other.age == age &&
        other.blood == blood &&
        other.type == type;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        nid.hashCode ^
        age.hashCode ^
        blood.hashCode ^
        type.hashCode;
  }
}
