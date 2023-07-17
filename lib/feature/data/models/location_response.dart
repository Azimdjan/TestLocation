/// place_id : 128079949
/// licence : "Data © OpenStreetMap contributors, ODbL 1.0. https://osm.org/copyright"
/// osm_type : "way"
/// osm_id : 89911874
/// lat : "50.50787255"
/// lon : "30.447448073322203"
/// display_name : "5, Западинська вулиця, ЖК Паркове місто, Подільський район, Київ, 04123, Україна"
/// address : {"house_number":"5","road":"Западинська вулиця","residential":"ЖК Паркове місто","borough":"Подільський район","city":"Київ","ISO3166-2-lvl4":"UA-30","postcode":"04123","country":"Україна","country_code":"ua"}
/// boundingbox : ["50.5077835","50.5079411","30.4470265","30.4478697"]

class LocationResponse {
  LocationResponse({
      this.placeId, 
      this.licence, 
      this.osmType, 
      this.osmId, 
      this.lat, 
      this.lon, 
      this.displayName, 
      this.address, 
      this.boundingbox,});

  LocationResponse.fromJson(dynamic json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'] != null ? json['boundingbox'].cast<String>() : [];
  }
  num? placeId;
  String? licence;
  String? osmType;
  num? osmId;
  String? lat;
  String? lon;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['place_id'] = placeId;
    map['licence'] = licence;
    map['osm_type'] = osmType;
    map['osm_id'] = osmId;
    map['lat'] = lat;
    map['lon'] = lon;
    map['display_name'] = displayName;
    if (address != null) {
      map['address'] = address?.toJson();
    }
    map['boundingbox'] = boundingbox;
    return map;
  }

}

/// house_number : "5"
/// road : "Западинська вулиця"
/// residential : "ЖК Паркове місто"
/// borough : "Подільський район"
/// city : "Київ"
/// ISO3166-2-lvl4 : "UA-30"
/// postcode : "04123"
/// country : "Україна"
/// country_code : "ua"

class Address {
  Address({
      this.houseNumber, 
      this.road, 
      this.residential, 
      this.borough, 
      this.city, 
      this.iSO31662lvl4, 
      this.postcode, 
      this.country, 
      this.countryCode,});

  Address.fromJson(dynamic json) {
    houseNumber = json['house_number'];
    road = json['road'];
    residential = json['residential'];
    borough = json['borough'];
    city = json['city'];
    iSO31662lvl4 = json['ISO3166-2-lvl4'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }
  String? houseNumber;
  String? road;
  String? residential;
  String? borough;
  String? city;
  String? iSO31662lvl4;
  String? postcode;
  String? country;
  String? countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['house_number'] = houseNumber;
    map['road'] = road;
    map['residential'] = residential;
    map['borough'] = borough;
    map['city'] = city;
    map['ISO3166-2-lvl4'] = iSO31662lvl4;
    map['postcode'] = postcode;
    map['country'] = country;
    map['country_code'] = countryCode;
    return map;
  }

}