class PDFDocument {
  final String id;
  final String title;
  final String path;
  final DateTime lastOpened;
  final int totalPages;
  final int currentPage;
  final List<Bookmark> bookmarks;
  final double readingProgress;

  PDFDocument({
    required this.id,
    required this.title,
    required this.path,
    required this.lastOpened,
    required this.totalPages,
    required this.currentPage,
    this.bookmarks = const [],
    double? readingProgress,
  }) : readingProgress = readingProgress ?? (currentPage / totalPages * 100);

  PDFDocument copyWith({
    String? id,
    String? title,
    String? path,
    DateTime? lastOpened,
    int? totalPages,
    int? currentPage,
    List<Bookmark>? bookmarks,
  }) {
    return PDFDocument(
      id: id ?? this.id,
      title: title ?? this.title,
      path: path ?? this.path,
      lastOpened: lastOpened ?? this.lastOpened,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
      bookmarks: bookmarks ?? this.bookmarks,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'path': path,
      'lastOpened': lastOpened.toIso8601String(),
      'totalPages': totalPages,
      'currentPage': currentPage,
      'bookmarks': bookmarks.map((b) => b.toJson()).toList(),
    };
  }

  factory PDFDocument.fromJson(Map<String, dynamic> json) {
    return PDFDocument(
      id: json['id'],
      title: json['title'],
      path: json['path'],
      lastOpened: DateTime.parse(json['lastOpened']),
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      bookmarks: (json['bookmarks'] as List?)
              ?.map((b) => Bookmark.fromJson(b))
              .toList() ??
          [],
    );
  }
}

class Bookmark {
  final String id;
  final int page;
  final String title;
  final DateTime created;

  Bookmark({
    required this.id,
    required this.page,
    required this.title,
    required this.created,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page': page,
      'title': title,
      'created': created.toIso8601String(),
    };
  }

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      id: json['id'],
      page: json['page'],
      title: json['title'],
      created: DateTime.parse(json['created']),
    );
  }
}
