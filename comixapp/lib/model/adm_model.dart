class AdmModel {
  String? uid;
  String? email;
  String? role;

  AdmModel({this.uid, this.email, this.role});

  // receiving data from server
  factory AdmModel.fromMap(map){
    return AdmModel(
        uid: map['uid'],
        email: map['email'],
        role: map['role']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'email': email,
      'role': role,
    };
  }
}