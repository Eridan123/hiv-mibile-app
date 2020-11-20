class PassagePoint {
  int passage_id;
  double latitude;
  double longitude;


  PassagePoint({this.latitude, this.longitude,this.passage_id});

  Map<String, dynamic> toJson() => {
    "lat" : latitude,
    "lng" : longitude,
    "passage_id" : passage_id,
  };

  factory PassagePoint.fromJson(Map<String, dynamic> json) {
    return PassagePoint(
      latitude:json[0],
      longitude:json[0],
      passage_id:json[0],
    );
  }
}