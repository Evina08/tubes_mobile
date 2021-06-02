import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubes_flutter/models/anggota.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //siswa
  Future<void> saveAnggota(Anggota anggota) {
    return _db
        .collection('anggota')
        .doc(anggota.idAnggota)
        .set(anggota.toMap());
  }

  Stream<List<Anggota>> getAnggota() {
    return _db.collection('anggota').snapshots().map((snapshot) => snapshot.docs
        .map((document) => Anggota.fromFirestore(document.data()))
        .toList());
  }

  Future<void> removeAnggota(String idAnggota) {
    return _db.collection('anggota').doc(idAnggota).delete();
  }
}
