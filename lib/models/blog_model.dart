class BlogModel {
  BlogModel({
    this.id,
    this.categoryId,
    this.title,
    this.subTitle,
    this.slug,
    this.description,
    this.image,
    this.video,
    this.date,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  BlogModel.fromJson(dynamic json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    slug = json['slug'];
    description = json['description'];
    image = json['image'];
    video = json['video'];
    date = json['date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  num? id;
  String? categoryId;
  String? title;
  String? subTitle;
  String? slug;
  String? description;
  dynamic image;
  dynamic video;
  String? date;
  String? status;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  BlogModel copyWith({
    num? id,
    String? categoryId,
    String? title,
    String? subTitle,
    String? slug,
    String? description,
    dynamic image,
    dynamic video,
    String? date,
    String? status,
    String? createdBy,
    String? updatedBy,
    String? createdAt,
    String? updatedAt,
  }) =>
      BlogModel(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        title: title ?? this.title,
        subTitle: subTitle ?? this.subTitle,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        image: image ?? this.image,
        video: video ?? this.video,
        date: date ?? this.date,
        status: status ?? this.status,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = categoryId;
    map['title'] = title;
    map['sub_title'] = subTitle;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    map['video'] = video;
    map['date'] = date;
    return map;
  }
}
