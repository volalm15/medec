enum Insurance {
  GKK,
  BVAEB,
  BVAOEB,
  SVSLW,
}
insuranceToString(Insurance insurace) {
  switch (insurace) {
    case Insurance.GKK:
      return "GKK";
    case Insurance.BVAEB:
      return "BVA-EB";
    case Insurance.BVAOEB:
      return "BVA-OEB";
    case Insurance.SVSLW:
      return "SVS-LW";
    default:
      return "Should not see me :)";
  }
}
