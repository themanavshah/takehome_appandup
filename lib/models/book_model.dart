//kind
//total items
//items
//---kind
//---id
//---etag
//---Volumeinfo
//------title
//------subtitle
//------authors
//------publishers
//------publisheddate
//------description
//------categories
//------avergareRatings
//------Imagelinks

class BookModel {
  BookModel({
    this.kind,
    this.totalItems,
    this.items,
  });

  String? kind;
  int? totalItems;
  List<Book>? items;

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      kind: json["kind"],
      totalItems: json["totalItems"],
      items: List<Book>.from(json["items"].map((x) => Book.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "totalItems": totalItems,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Book {
  Book({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
  });

  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      kind: json["kind"],
      id: json["id"],
      etag: json["etag"],
      selfLink: json["selfLink"],
      volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": volumeInfo?.toJson(),
      };
}

class VolumeInfo {
  VolumeInfo({
    this.title,
    this.subtitle,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    this.categories,
    this.averageRating,
    this.imageLinks,
  });

  String? title;
  String? subtitle;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  String? description;
  int? pageCount;
  List<String>? categories;
  double? averageRating;
  ImageLinks? imageLinks;

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json["title"],
      subtitle: json["subtitle"] ?? "no subtitle",
      authors: json["authors"] == null
          ? []
          : List<String>.from(json["authors"].map((x) => x)),
      publisher: json["publisher"],
      publishedDate: json["publishedDate"],
      description: json["description"] ?? "no description",
      pageCount: json["pageCount"],
      categories: json["categories"] == null
          ? []
          : List<String>.from(json["categories"].map((x) => x.toString())),
      averageRating: json["averageRating"] == null
          ? null
          : double.parse(json["averageRating"].toString()),
      // ignore: prefer_if_null_operators
      imageLinks: ImageLinks.fromJson(json["imageLinks"] == null
          ? {
              "smallThumbnail": "not found",
              "thumbnail": "not found",
            }
          : json["imageLinks"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle ?? "no subtitle",
        "authors": List<String>.from(authors!.map((x) => x)),
        "publisher": publisher,
        "publishedDate": publishedDate,
        "description": description ?? "no subtitle",
        "pageCount": pageCount,
        "categories": List<dynamic>.from(categories!.map((x) => x)),
        "averageRating": averageRating == null
            ? null
            : double.parse(averageRating.toString()),
        "imageLinks": imageLinks?.toJson(),
      };
}

class ImageLinks {
  ImageLinks({
    this.smallThumbnail = "st image not found",
    this.thumbnail = "t image not found",
  });

  String smallThumbnail;
  String thumbnail;

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      smallThumbnail: json["smallThumbnail"],
      thumbnail: json["thumbnail"],
    );
  }

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
      };
}
