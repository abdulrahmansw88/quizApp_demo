import 'dart:convert';

DepartmentModel departmentModelFromJson(String string)=> DepartmentModel.fromJson(jsonDecode(string));
String departmentModelToJson(DepartmentModel data) => json.encode(data.toJson());
class DepartmentModel{
   int  id;
   String userName;
   String password;
   String userDepartment;
  DepartmentModel({
    required this.id,
    required this.userDepartment,
    required this.userName,
    required this.password
  });

  // factory DepartmentModel.fromMap(Map<String, dynamic> json){
  //   return DepartmentModel(id : json['id'], userDepartment : json['department'], userName : json['userName'], password : json['password']);
  // }

   Map<String, dynamic> toJson() => {
     "id": id,
     "userName": userName,
     "password": password,
     "department": userDepartment,
   };

factory DepartmentModel.fromJson(Map<String, dynamic> json)=>DepartmentModel(
    id:  json['id'],
    userDepartment: json["userDepartment"],
    userName: json["userName"],
    password: json["password"]
);
}