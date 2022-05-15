import 'dart:typed_data';

class AddRewardRequest {
  String? name; //done
  String? content; //done
  String? institutionId; //done
  int? points; //done
  Uint8List? image;
  DateTime? expiryDate;
  int? numbers; //done

  AddRewardRequest({
    this.name,
    this.institutionId,
    this.content,
    this.image,
    this.points,
    this.numbers,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['content'] = content;
    data['institutionId'] = institutionId;
    data['points'] = points;
    data['numbers'] = numbers;
    data['expiryDate'] = expiryDate;
    return data;
  }
}
