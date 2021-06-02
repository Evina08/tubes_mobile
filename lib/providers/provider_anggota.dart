import 'package:flutter/material.dart';
import 'package:tubes_flutter/services/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:tubes_flutter/models/anggota.dart';

class AnggotaProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  String _idAnggota;
  String _namaAnggota;
  int _nik;
  int _umur;
  String _jenisMember;
  var uuid = Uuid();

  //Getters
  int get nik => _nik;
  int get umur => _umur;
  String get namaAnggota => _namaAnggota;
  String get jenisMember => _jenisMember;

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

  //read
  loadValues(Anggota anggota) {
    _nik = anggota.nik;
    _umur = anggota.umur;
    _namaAnggota = anggota.namaAnggota;
    _jenisMember = anggota.jenisMember;
  }

//create/update
  saveAnggota() {
    print(_idAnggota);
    if (_idAnggota == null) {
      var newAnggota = Anggota(
          nik: nik,
          umur: umur,
          namaAnggota: namaAnggota,
          jenisMember: jenisMember,
          idAnggota: uuid.v4());
      firestoreService.saveAnggota(newAnggota);
    } else {
      //Update
      var updatedAnggota = Anggota(
          nik: nik,
          umur: umur,
          namaAnggota: namaAnggota,
          jenisMember: jenisMember,
          idAnggota: _idAnggota);
      firestoreService.saveAnggota(updatedAnggota);
    }
  }

//delete
  removeAnggota(String idAnggota) {
    firestoreService.removeAnggota(idAnggota);
  }
}
