class Header {
  Header({
    required this.title,
    required this.start,
    required this.end,
  });

  late final String title;
  late final String start;
  late final String end;

  Header.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    start = json['start'];
    end = json['end'];
  }
}
