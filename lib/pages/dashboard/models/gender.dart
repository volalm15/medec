enum Gender {
  MALE,
  FEMALE,
}

genderToString(Gender gender) {
  switch (gender) {
    case Gender.MALE:
      return "Male";
    case Gender.FEMALE:
      return "Female";
    default:
      return "Should not see me :)";
  }
}
