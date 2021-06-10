class Anggota {
  final String idAnggota;
  final String namaAnggota;
  final int umur;
  final int nik;
  final String jenisMember;
  final String createdBy;

  Anggota(
      {this.idAnggota,
      this.namaAnggota,
      this.umur,
      this.nik,
      this.jenisMember,
      this.createdBy});

  Map<String, dynamic> toMap() {
    return {
      'idAnggota': idAnggota,
      'namaAnggota': namaAnggota,
      'umur': umur,
      'nik': nik,
      'jenisMember': jenisMember,
      'createdBy': createdBy
    };
  }

  Anggota.fromFirestore(Map<String, dynamic> firestore)
      : idAnggota = firestore['idAnggota'],
        namaAnggota = firestore['namaAnggota'],
        umur = firestore['umur'],
        nik = firestore['nik'],
        jenisMember = firestore['jenisMember'],
        createdBy = firestore['createdBy'];
}
