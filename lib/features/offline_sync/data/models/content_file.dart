// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:googleapis/drive/v3.dart';

class ContentFile extends File {
  final String content;
  final String fileName;

  ContentFile({required this.content, required this.fileName});
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['content'] = content;
    return data;
  }

  @override
  factory ContentFile.fromJson(Map<String, dynamic> json) {
    return ContentFile(
      content: json['content'] as String,
      fileName: json['fileName'] as String,
    );
  }

  ContentFile copyWith({String? content, String? fileName}) {
    return ContentFile(
      content: content ?? this.content,
      fileName: fileName ?? this.fileName,
    );
  }
}
