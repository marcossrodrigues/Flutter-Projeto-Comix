class UsuarioModel {
  String? uid;
  String? email;
  String? role;

  UsuarioModel({this.uid, this.email, this.role});

  // receiving data from server
  factory UsuarioModel.fromMap(map){
    return UsuarioModel(
        uid: map['uid'],
        email: map['email'],
        role: map['role']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
    };
  }
}