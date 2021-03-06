import 'package:flutter/material.dart';
import 'package:tubes_flutter/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:tubes_flutter/models/anggota.dart';
import 'package:tubes_flutter/services/sign_in.dart';

class AnggotaProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _idAnggota;
  String _namaAnggota;
  int _nik;
  int _umur;
  String _jenisMember;
  String _createdBy;
  var uuid = Uuid();

  //Getters
  int get nik => _nik;
  int get umur => _umur;
  String get namaAnggota => _namaAnggota;
  String get jenisMember => _jenisMember;
  String get createdBy => _createdBy;

  //Setters
  changeNik(String value) {
    _nik = int.parse(value);
    notifyListeners();
  }

  changeUmur(String value) {
    _umur = int.parse(value);
    notifyListeners();
  }

  changeNamaAnggota(String value) {
    _namaAnggota = value;
    notifyListeners();
  }

  changeJenisMember(String value) {
    _jenisMember = value;
    notifyListeners();
  }

  changeCreatedBy() {
    _createdBy = uid;
    notifyListeners();
  }

  //read
  loadValues(String idAnggota, String namaAnggota, String jenisMember, int nik,
      int umur) {
    _idAnggota = idAnggota;
    _nik = nik;
    _umur = umur;
    _namaAnggota = namaAnggota;
    _jenisMember = jenisMember;
    // _createdBy = anggota.createdBy;
  }

//create/update
  saveAnggota(String ada) {
    print(_idAnggota);
    if (ada == "kosong") {
      var newAnggota = Anggota(
          nik: nik,
          umur: umur,
          namaAnggota: namaAnggota,
          jenisMember: jenisMember,
          createdBy: uid,
          idAnggota: uuid.v4());
      firestoreService.saveAnggota(newAnggota);
    } else {
      //Update
      var updatedAnggota = Anggota(
          nik: _nik,
          umur: _umur,
          namaAnggota: _namaAnggota,
          jenisMember: _jenisMember,
          createdBy: uid,
          idAnggota: _idAnggota);
      firestoreService.saveAnggota(updatedAnggota);
    }
  }

//delete
  removeAnggota(String idAnggota) {
    firestoreService.removeAnggota(idAnggota);
  }
}
