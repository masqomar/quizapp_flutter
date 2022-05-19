class ArticleModel {
  int? id;
  String? judul;
  String? deskripsi;
  String? gambar;
  String? sumber;
  String? createdAt;
  String? updatedAt;

  ArticleModel(
      {this.id,
      this.judul,
      this.deskripsi,
      this.gambar,
      this.sumber,
      this.createdAt,
      this.updatedAt});

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    gambar = json['gambar'];
    sumber = json['sumber'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['judul'] = judul;
    data['deskripsi'] = deskripsi;
    data['gambar'] = gambar;
    data['sumber'] = sumber;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
