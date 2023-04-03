class UserModel {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  int? cNIC;
  String? profilePicture;
  String? dOB;
  String? password;
  String? confirmPassword;
  String? phoneNum;
  String? ref;
  String? gender;

  UserModel(
      {this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.cNIC,
      this.profilePicture,
      this.dOB,
      this.ref});

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cNIC = json['CNIC'];
    profilePicture = json['profile_picture'];
    dOB = json['DOB'];
    ref = json['referral_code'];
    phoneNum = json['phone_number'] ;
  }

  Map<String, dynamic> toJson({
    required String username,
    required String email,
    required String firstName,
    required String lastName,
    required int cNIC,
    profilePicture,
    required String password,
    required String confirmpassword,
    required String dOB,
    required String phonNum,
    required String gender,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['CNIC'] = cNIC;
    data['profile_picture'] = profilePicture;
    data['DOB'] = dOB;
    data['password'] = password;
    data['re_password'] = confirmpassword;
    data['phone_number'] = phonNum;
    return data;
  }
}

class UserRank {
  int? rank;
  WaitlistUser? user;
  UserRank({this.rank, this.user});

  UserRank.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    user = WaitlistUser.toJson(json);
  }
}
class WaitlistUser{
  String? name;
  WaitlistUser({this.name});
  WaitlistUser.toJson(Map< String,dynamic> json){
    name = json['name'];
  }
}

