import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tubes_flutter/screens/form_anggota.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/models/anggota.dart';
import 'package:tubes_flutter/providers/provider_anggota.dart';
import 'package:tubes_flutter/models/anggota.dart';
import 'package:tubes_flutter/services/sign_in.dart';

class AnggotaPage extends StatefulWidget {
  final Anggota anggota;

  AnggotaPage([this.anggota]);

  @override
  _AnggotaPageState createState() => _AnggotaPageState();
}

class _AnggotaPageState extends State<AnggotaPage> {
  @override
  Widget build(BuildContext context) {
    final anggota = Provider.of<List<Anggota>>(context);
    final anggotaProvider = Provider.of<AnggotaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Anggota'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_to_photos_sharp,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      FormAnggota(null, null, null, null, null),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('anggota')
              .where('createdBy', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Text('PLease Wait')
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data.docs[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.people),
                          ),
                          title: Text(data['namaAnggota']),
                          // trailing: Text(
                          //   anggota[index].jenisMember,
                          // ),
                          subtitle: Text("Jenis Member: " +
                              data['jenisMember'] +
                              "  Umur: " +
                              data['umur'].toString()),
                          trailing: GestureDetector(
                            child: Icon(Icons.delete_sweep_rounded),
                            onTap: () {
                              anggotaProvider.removeAnggota(data.id);
                              Navigator.of(context).pop();
                            },
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FormAnggota(
                                  data.id.toString(),
                                  data['namaAnggota'].toString(),
                                  data['jenisMember'].toString(),
                                  data['nik'],
                                  data['umur'],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
          }),
    );
  }
}
