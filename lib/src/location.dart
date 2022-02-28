class Location {
  Location(
      {this.address,
      this.crossStreet,
      this.lat,
      this.lng,
      this.distance,
      this.postalCode,
      this.cc,
      this.city,
      this.state,
      this.country,
      this.formattedAddress});

  final String? address;
  final String? crossStreet;
  final String? lat;
  final String? lng;
  final String? distance;
  final String? postalCode;
  final String? cc;
  final String? city;
  final String? state;
  final String? country;
  final String? formattedAddress;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        address: json['address'] ?? '',
        crossStreet: json['crossStreet'] ?? '',
        lat: json['lat'] ?? '',
        lng: json['lng'] ?? '',
        distance: json['distance'] ?? '',
        postalCode: json['postalCode'] ?? '',
        cc: json['cc'] ?? '',
        city: json['city'] ?? '',
        state: json['state'] ?? '',
        country: json['country'] ?? '',
        formattedAddress: json['formattedAddress'] ?? '');
  }
}
