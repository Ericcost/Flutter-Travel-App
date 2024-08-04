class Trip {
  final String title;
  final List<String> pictures;
  final String description;
  final DateTime date;
  final String location; // a enum can be use here if you want to retrieve lattitude and longitude.

  Trip({
    required this.title,
    required this.pictures,
    required this.description,
    required this.date,
    required this.location
  });
}