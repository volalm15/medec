enum Insurance {
  GKK,
  BVAEB,
  BVAOEB,
  SVS,
}
insuranceToString(Insurance insurace) {
  switch (insurace) {
    case Insurance.GKK:
      return "GKK";
    case Insurance.BVAEB:
      return "BVA-EB";
    case Insurance.BVAOEB:
      return "BVA-OEB";
    case Insurance.SVS:
      return "SVS";
    default:
      return "Should not see me :)";
  }
}
