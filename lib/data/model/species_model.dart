 
class SpeciesModel {
  int? taxonid;
  String? scientificName;
  String? subspecies;
  String? rank;
  String? subpopulation;

  SpeciesModel({this.taxonid, this.scientificName, this.subspecies, this.rank, this.subpopulation});

  SpeciesModel.fromJson(Map<String, dynamic> json) {
    taxonid = json['taxonid'];
    scientificName = json['scientific_name'];
    subspecies = json['subspecies'];
    rank = json['rank'];
    subpopulation = json['subpopulation'];
  }
}
