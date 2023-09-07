

class BooksDraft{
  final int id;
  final String header;
  final String body;
  final String cover;

  BooksDraft({required this.header, required this.body, required this.cover, required this.id});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'header': header,
      'body': body,
      'cover': cover,
    };
  }

  factory BooksDraft.fromJson(Map<String, dynamic> json) {
    return BooksDraft(
      id: json['id'],
      header: json['header'] as String,
      body: json['body']as String,
      cover: json['cover']as String,
    );
  }

