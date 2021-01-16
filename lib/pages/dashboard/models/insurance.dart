enum Insurance { OEGK, AUVA, BVAEB, SVS, PVA }
insuranceToString(Insurance insurace) {
  switch (insurace) {
    case Insurance.OEGK:
      return "ÖGK";
    case Insurance.BVAEB:
      return "BVA-EB";
    case Insurance.PVA:
      return "PVA";
    case Insurance.SVS:
      return "SVS";
    case Insurance.AUVA:
      return "AUVA";
    default:
      return "Should not see me :)";
  }
}
