class TextModel {
  String? text;
  String? category;

  TextModel({this.text, this.category});

  TextModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['category'] = category;
    return data;
  }
}
