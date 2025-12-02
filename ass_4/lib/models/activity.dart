class Activity {
  final String id;
  final String image; // Base64 image
  final String location; // "lat, long"
  final String timestamp;

  Activity({
    required this.id,
    required this.image,
    required this.location,
    required this.timestamp,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json["id"],
      image: json["image"],
      location: json["location"],
      timestamp: json["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "location": location,
      "timestamp": timestamp,
    };
  }
}
