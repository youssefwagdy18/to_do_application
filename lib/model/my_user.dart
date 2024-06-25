class MyUser {
  static const String routeName = 'myUser';

  //todo attributes for myUser
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  MyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  //todo toFireStore => object to json
  Map<String, dynamic> toFireStore(MyUser myUser) {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email
    };
  }

  //todo fromFireStore => json to object
  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
          id: data?['id'] as String,
          firstName: data?['firstName'] as String,
          lastName: data?['lastName'] as String,
          email: data?['email'] as String,
        );
}
