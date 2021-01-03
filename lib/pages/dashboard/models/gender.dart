enum Gender {
  MALE,
  FEMALE,
  NONE,
}

genderToString(Gender gender) {
  switch (gender) {
    case Gender.MALE:
      return "Male";
    case Gender.FEMALE:
      return "Female";
    case Gender.NONE:
      return "None";
    default:
      return "Should not see me :)";
  }
}
