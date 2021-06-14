class Book {
  String idBuku;
  String kategori;
  String namaBuku;
  String penerbit;
  String penulis;
  int jumlahBuku;
  String createdBy;

  Book({
    this.idBuku,
    this.kategori,
    this.namaBuku,
    this.penerbit,
    this.penulis,
    this.jumlahBuku,
    this.createdBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'idBuku': idBuku,
      'kategori': kategori,
      'namaBuku': namaBuku,
      'penerbit': penerbit,
      'penulis': penulis,
      'jumlahBuku': jumlahBuku,
      'createdBy': createdBy,
    };
  }

  Book.fromFirestore(Map<String, dynamic> firestore)
      : idBuku = firestore['idBuku'],
        kategori = firestore['kategori'],
        namaBuku = firestore['namaBuku'],
        penerbit = firestore['penerbit'],
        penulis = firestore['penulis'],
        jumlahBuku = firestore['jumlahBuku'],
        createdBy = firestore['createdBy'];
}
