class UserWaitlist {
  final User? user;
  final int? rank;

  UserWaitlist({
    this.user,
    this.rank,
  });

  UserWaitlist.fromJson(Map<String, dynamic> json)
      : user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        rank = json['rank'] as int?;

  Map<String, dynamic> toJson() => {'user': user?.toJson(), 'rank': rank};
}

class User {
  final String? name;
  final String? gender;

  User({
    this.name,
    this.gender,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        gender = json['gender'] as String?;

  Map<String, dynamic> toJson() => {'name': name, 'gender': gender};
}
