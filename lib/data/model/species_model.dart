class SpeciesModel {
  int? taxonid;
  String? scientificName;
  String? subspecies;
  String? rank;
  String? subpopulation;

  String? taxonomicNotes;
  String? rationale;
  String? geographicRange;
  String? population;
  String? populationTrend;
  String? habitat;
  String? threats;
  String? conservationMeasures;
  String? useTrade;

  SpeciesModel({
    this.taxonid,
    this.scientificName,
    this.subspecies,
    this.rank,
    this.subpopulation,
    this.taxonomicNotes,
    this.rationale,
    this.geographicRange,
    this.population,
    this.populationTrend,
    this.habitat,
    this.threats,
    this.conservationMeasures,
    this.useTrade,
  });

  factory SpeciesModel.fromJson(Map<String, dynamic> json) {
    return SpeciesModel(
      taxonid: json['taxonid'],
      scientificName: json['scientific_name'],
      subspecies: json['subspecies'],
      rank: json['rank'],
      subpopulation: json['subpopulation'],
    );
  }

  factory SpeciesModel.fromNarrativeJson(Map<String, dynamic> json) {
    return SpeciesModel(
      taxonid: json['species_id'],
      taxonomicNotes: json['taxonomicnotes'],
      rationale: json['rationale'],
      geographicRange: json['geographicrange'],
      population: json['population'],
      populationTrend: json['populationtrend'],
      habitat: json['habitat'],
      threats: json['threats'],
      conservationMeasures: json['conservationmeasures'],
      useTrade: json['usetrade'],
    );
  }
}
