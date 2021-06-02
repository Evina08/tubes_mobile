import 'package:flutter/material.dart';
import 'package:tubes_flutter/screens/form_anggota.dart';
import 'package:provider/provider.dart';
import 'package:tubes_flutter/models/anggota.dart';
import 'package:tubes_flutter/providers/provider_anggota.dart';
import 'package:tubes_flutter/models/anggota.dart';

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
                  builder: (context) => FormAnggota(),
                ),
              );
            },
          )
        ],
      ),
      body: (anggota != null)
          ? ListView.builder(
              itemCount: anggota.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.people),
                    ),
                    title: Text(anggota[index].namaAnggota),
                    // trailing: Text(
                    //   anggota[index].jenisMember,
                    // ),
                    subtitle: Text("Jenis Member: " +
                        anggota[index].jenisMember +
                        "  Umur: " +
                        anggota[index].umur.toString()),
                    trailing: GestureDetector(
                      child: Icon(Icons.delete_sweep_rounded),
                      onTap: () {
                        anggotaProvider.removeAnggota(widget.anggota.idAnggota);
                        Navigator.of(context).pop();
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FormAnggota(
                            anggota[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
