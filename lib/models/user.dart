class UserModel{
  int id;
  String email;
  String password;

  UserModel({this.id, this.email, this.password});

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "id":id,
      "email":email,
      "password":password,
    };
  }
}
