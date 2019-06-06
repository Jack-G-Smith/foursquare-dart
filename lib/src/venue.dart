import 'api.dart';

class Venue {
  Venue({this.venueId, this.name, this.location, this.city, this.state, this.cc, this.category, this.rating, this.photoPrefix, this.photoSuffix});

  final String venueId;
  final String name;
  final String location;
  final String city;
  final String state;
  final String cc;
  final String category;
  final double rating;
  final String photoPrefix;
  final String photoSuffix;

  @override
  String toString() {
    return '$venueId, $name, $location, $category, $rating';
  }

  bool operator ==(otherVenue) => otherVenue is Venue && venueId == otherVenue.venueId;
  int get hashCode => venueId.hashCode;

  factory Venue.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      return Venue(
          venueId: json['id'],
          name: json['name'],
          location: '${json['location']['city']}, ${json['location']['state']}, ${json['location']['cc']}' ?? '',
          city: json['city'],
          state: json['state'],
          cc: json['cc'],
          category: json['categories'][0]['name'] ?? '',
          rating: json['rating'],
          photoPrefix: json['bestPhoto']['prefix'],
          photoSuffix: json['bestPhoto']['suffix']
      );
    } else {
      return null;
    }
  }

  static Future<Venue> get(API api, String venueId) async {
    return Venue.fromJson((await api.get('venues/$venueId'))['venue']);
  }

  static Future<List<Venue>> search(API api, double latitude, double longitude, [String parameters='']) async {
    List items = (await api.get('venues/search', '&ll=$latitude,$longitude$parameters'))['venues'];
    return items.map((item) => Venue.fromJson(item)).toList();
  }

  static Future<Venue> current(API api, double latitude, double longitude) async {
    return (await Venue.search(api, latitude, longitude, '&limit=1')).elementAt(0);
  }

  static Future<List<Venue>> recommendations(API api, double latitude, double longitude, [String parameters='']) async {
    List items = (await api.get('search/recommendations', '&ll=$latitude,$longitude$parameters'))['group']['results'];
    return items.map((item) => Venue.fromJson(item['venue']));
  }

  static Future<List<Venue>> liked(API api, {userId = 'self'}) async {
    List items = (await api.get('lists/$userId/venuelikes', '&limit=10000'))['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toList();
  }

  static Future<List<Venue>> saved(API api, {userId = 'self'}) async {
    List items = (await api.get('lists/$userId/todos', '&limit=10000'))['list']['listItems']['items'];
    return items
      .where((item) => item['type'] == 'venue')
      .map((item) => Venue.fromJson(item['venue'])).toList();
  }
}
