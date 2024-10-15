// Complete Article model as received in API response
import 'dart:convert';

class ArticleModel {
  ArticleModel({
    this.status,
    this.copyright,
    this.numResults,
    this.results,
  });

  String? status;
  String? copyright;
  int? numResults;
  List<Article>? results;

  factory ArticleModel.fromRawJson(String str) => ArticleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        status: json["status"],
        copyright: json["copyright"],
        numResults: json["num_results"],
        results: json["results"] == null ? [] : List<Article>.from(json["results"]!.map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "num_results": numResults,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.uri,
    this.url,
    this.id,
    this.assetId,
    this.source = '',
    this.publishedDate,
    this.updated,
    this.section,
    this.subsection,
    this.nytdsection,
    this.adxKeywords,
    this.column,
    this.byline = '',
    this.type,
    this.title = '',
    this.resultAbstract,
    this.desFacet,
    this.orgFacet,
    this.perFacet,
    this.geoFacet,
    this.media,
    this.etaId,
    this.thumb,
    this.image,
  });

  String? uri;
  String? url;
  int? id;
  int? assetId;
  String source;
  DateTime? publishedDate;
  DateTime? updated;
  String? section;
  String? subsection;
  String? nytdsection;
  String? adxKeywords;
  dynamic column;
  String byline;
  String? type;
  String title;
  String? resultAbstract;
  List<String>? desFacet;
  List<String>? orgFacet;
  List<String>? perFacet;
  List<String>? geoFacet;
  List<Media>? media;
  int? etaId;
  String? thumb;
  String? image;

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        uri: json["uri"],
        url: json["url"],
        id: json["id"],
        assetId: json["asset_id"],
        source: json["source"] ?? '',
        publishedDate: json["published_date"] == null ? null : DateTime.parse(json["published_date"]),
        updated: json["updated"] == null ? null : DateTime.parse(json["updated"]),
        section: json["section"],
        subsection: json["subsection"],
        nytdsection: json["nytdsection"],
        adxKeywords: json["adx_keywords"],
        column: json["column"],
        byline: json["byline"] ?? '',
        type: json["type"],
        title: json["title"] ?? '',
        resultAbstract: json["abstract"],
        desFacet: json["des_facet"] == null ? [] : List<String>.from(json["des_facet"]!.map((x) => x)),
        orgFacet: json["org_facet"] == null ? [] : List<String>.from(json["org_facet"]!.map((x) => x)),
        perFacet: json["per_facet"] == null ? [] : List<String>.from(json["per_facet"]!.map((x) => x)),
        geoFacet: json["geo_facet"] == null ? [] : List<String>.from(json["geo_facet"]!.map((x) => x)),
        media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        etaId: json["eta_id"],
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "url": url,
        "id": id,
        "asset_id": assetId,
        "source": source,
        "published_date":
            "${publishedDate!.year.toString().padLeft(4, '0')}-${publishedDate!.month.toString().padLeft(2, '0')}-${publishedDate!.day.toString().padLeft(2, '0')}",
        "updated": updated?.toIso8601String(),
        "section": section,
        "subsection": subsection,
        "nytdsection": nytdsection,
        "adx_keywords": adxKeywords,
        "column": column,
        "byline": byline,
        "type": type,
        "title": title,
        "abstract": resultAbstract,
        "des_facet": desFacet == null ? [] : List<dynamic>.from(desFacet!.map((x) => x)),
        "org_facet": orgFacet == null ? [] : List<dynamic>.from(orgFacet!.map((x) => x)),
        "per_facet": perFacet == null ? [] : List<dynamic>.from(perFacet!.map((x) => x)),
        "geo_facet": geoFacet == null ? [] : List<dynamic>.from(geoFacet!.map((x) => x)),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
        "eta_id": etaId,
      };

  //Extracting Media thumbnail
  String? get mediaThumb {
    String? thumb;
    if (media?.isNotEmpty ?? false) {
      var med = media?.elementAt(0) ?? Media();
      if (med.type == 'image' && med.mediaMetadata != null && med.mediaMetadata?.length == 3) {
        thumb = med.mediaMetadata?.elementAt(0).url;
      }
    }
    this.thumb = thumb;
    return thumb;
  }

  // Extracting image URL
  String? get imageUrl {
    String? img;
    if (media?.isNotEmpty ?? false) {
      var med = media?.elementAt(0) ?? Media();
      if (med.type == 'image' && med.mediaMetadata != null && med.mediaMetadata?.length == 3) {
        img = med.mediaMetadata?.elementAt(2).url;
      }
    }
    image = image;
    return img;
  }
}

class Media {
  Media({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  String? type;
  String? subtype;
  String? caption;
  String? copyright;
  int? approvedForSyndication;
  List<MediaMetadatum>? mediaMetadata;

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json["type"],
        subtype: json["subtype"],
        caption: json["caption"],
        copyright: json["copyright"],
        approvedForSyndication: json["approved_for_syndication"],
        mediaMetadata: json["media-metadata"] == null
            ? []
            : List<MediaMetadatum>.from(json["media-metadata"]!.map((x) => MediaMetadatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "caption": caption,
        "copyright": copyright,
        "approved_for_syndication": approvedForSyndication,
        "media-metadata": mediaMetadata == null ? [] : List<dynamic>.from(mediaMetadata!.map((x) => x.toJson())),
      };
}

class MediaMetadatum {
  MediaMetadatum({
    this.url,
    this.format,
    this.height,
    this.width,
  });

  String? url;
  String? format;
  int? height;
  int? width;

  factory MediaMetadatum.fromRawJson(String str) => MediaMetadatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaMetadatum.fromJson(Map<String, dynamic> json) => MediaMetadatum(
        url: json["url"],
        format: json["format"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "format": format,
        "height": height,
        "width": width,
      };
}
