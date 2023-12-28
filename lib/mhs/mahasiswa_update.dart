// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sister/const.dart';

class MahasiswaUpdate extends StatefulWidget {
  final int idup;
  final String namaup;
  final String emailup;
  final DateTime tglLahirup;

  MahasiswaUpdate({
    required this.idup,
    required this.namaup,
    required this.emailup,
    required this.tglLahirup,
  });

  @override
  State<MahasiswaUpdate> createState() => _MahasiswaUpdateState();
}

class _MahasiswaUpdateState extends State<MahasiswaUpdate> {
  late int id;
  late final TextEditingController _nama;
  late final TextEditingController _email;
  late DateTime tglLahir;

  @override
  void initState() {
    super.initState();
    _nama = TextEditingController(text: widget.namaup ?? '');
    _email = TextEditingController(text: widget.emailup ?? '');
    id = widget.idup;
    // _nama.text = widget.namaup;
    // _email.text = widget.emailup;
    tglLahir = widget.tglLahirup;
  }

  Future<void> _pilihTgl(BuildContext context) async {
    final DateTime? kalender = await showDatePicker(
        context: context,
        initialDate: tglLahir,
        firstDate: DateTime(1950),
        lastDate: DateTime(2030));

    if (kalender != null && kalender != tglLahir) {
      setState(() {
        tglLahir = kalender;
      });
    }
  }

  Future<void> updateMhs() async {
    String urlInsert =
        "$url_mhs/api/v1/mahasiswa/${id}?nama=${_nama.text}&&email=${_email.text}&&tglLahir=${"${tglLahir.toLocal()}".split(" ")[0]}";

    try {
      var response = await http.put(
        Uri.parse(urlInsert),
      );
      if (response.statusCode == 200) {
        Navigator.pop(context);
      } else {
        print(response.statusCode);
      }
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Mahasiswa",
          style: TextStyle(
            fontSize: judul,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 80, left: 20, right: 20, bottom: 20),
            child: TextField(
              controller: _nama,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.purple,
                  labelText: "Nama",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusColor: Colors.purple,
                  labelText: "Email",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Tanggal Lahir",
                hintText: "Pilih Tanggal Lahir",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fillColor: Colors.deepPurple.shade200,
                prefixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () => _pilihTgl(context),
              controller: TextEditingController(
                text: "${tglLahir.toLocal()}".split(" ")[0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  updateMhs();
                },
                child: Text("Simpan")),
          )
        ],
      ),
    );
  }
}
