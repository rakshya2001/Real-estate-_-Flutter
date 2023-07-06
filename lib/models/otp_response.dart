class OtpHashData {
  String? phone;
  String? hash;

  OtpHashData({
    this.phone,
    this.hash,
  });

  // set from json
  factory OtpHashData.fromJson(Map<String, dynamic> json) {
    return OtpHashData(
      phone: json["phone"],
      hash: json["hash"],
    );
  }
}
