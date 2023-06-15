class DocumentModel {
  bool? success;
  List<Data>? data;

  DocumentModel({this.success, this.data});

  DocumentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? uid;
  int? createdAt;
  String? title;
  List<Null>? content;
  int? iV;

  Data({this.sId, this.uid, this.createdAt, this.title, this.content, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    createdAt = json['createdAt'];
    title = json['title'];
    // if (json['content'] != null) {
    //   content = <Null>[];
    //   json['content'].forEach((v) {
    //     content!.add(new Null.fromJson(v));
    //   });
    // }
    // iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    // if (this.content != null) {
    //   data['content'] = this.content!.map((v) => v.toJson()).toList();
    // }
    data['__v'] = this.iV;
    return data;
  }
}





// import 'dart:convert';

// class DocumentModel {
//   final String title;
//   final String uid;
//   final List content;
//   final DateTime createdAt;
//   final String id;
//   DocumentModel({
//     required this.title,
//     required this.uid,
//     required this.content,
//     required this.createdAt,
//     required this.id,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'title': title,
//       'uid': uid,
//       'content': content,
//       'createdAt': createdAt.millisecondsSinceEpoch,
//       'id': id,
//     };
//   }

//   factory DocumentModel.fromMap(Map<String, dynamic> map) {
//     return DocumentModel(
//       title: map['title'] ?? '',
//       uid: map['uid'] ?? '',
//       content: [] ,
//       createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
//       id: map['_id'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DocumentModel.fromJson(String source) => DocumentModel.fromMap(json.decode(source));
// }
