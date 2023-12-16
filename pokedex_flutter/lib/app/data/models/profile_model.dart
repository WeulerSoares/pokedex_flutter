enum Gender {
  male,
  female,
}

class ProfileModel {
  String _name;
  DateTime _birthDate;
  Gender _gender;

  ProfileModel({
    required String name,
    required DateTime birthDate,
    required Gender gender,
  })   : _name = name,
        _birthDate = birthDate,
        _gender = gender;

  String get name => _name;
  set name(String value) => _name = value;

  DateTime get birthDate => _birthDate;
  set birthDate(DateTime value) => _birthDate = value;

  Gender get gender => _gender;
  set gender(Gender value) => _gender = value;
}