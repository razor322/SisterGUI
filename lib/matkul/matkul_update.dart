import 'package:flutter/material.dart';
import 'package:sister/const.dart';
import 'package:http/http.dart' as http;

class MatkulUpdate extends StatefulWidget {
  final int idup;
  final String namaup;
  final String kodeup;
  final String sksup;

  MatkulUpdate({
    required this.idup,
    required this.namaup,
    required this.kodeup,
    required this.sksup,
  });
  @override
  State<MatkulUpdate> createState() => _MatkulUpdateState();
}

class _MatkulUpdateState extends State<MatkulUpdate> {
  late int id;
  // final TextEditingController _nama;
  // final TextEditingController _kode;
  // final TextEditingController _sks;

  final _kode = TextEditingController();
  final _nama = TextEditingController();
  final _sks = TextEditingController();

  @override
  void initState() {
    _kode.text = widget.kodeup;
    _nama.text = widget.namaup;
    _sks.text = widget.sksup;
    id = widget.idup;

    super.initState();
  }

  Future<void> updateMatkul() async {
    String urlInsert =
        "$url_matkul/matkul/${id}?nama=${_nama.text}&&kode=${_kode.text}&&sks=${_sks.text}";

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
          "Update Mata Kuliah",
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
                suffixIcon: const Icon(
                  Icons.book,
                  color: Colors.purple,
                ),
                labelText: "Nama Mata Kuliah",
                hintText: "Masukkan nama mata kuliah",
                hintStyle: const TextStyle(fontSize: 14),
                labelStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: TextField(
              controller: _kode,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: const Icon(
                    Icons.category_rounded,
                    color: Colors.purple,
                  ),
                  hintText: "Masukkan Kode Mata Kuliah",
                  hintStyle: const TextStyle(fontSize: 14),
                  focusColor: Colors.purple,
                  labelText: "Kode Mata Kuliah",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: TextField(
              controller: _sks,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.purple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: const Icon(
                    Icons.numbers,
                    color: Colors.purple,
                  ),
                  hintText: "Masukkan Jumlah Mata Kuliah",
                  hintStyle: const TextStyle(fontSize: 14),
                  focusColor: Colors.purple,
                  labelText: "Jumlah Mata Kuliah",
                  labelStyle: const TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
                onPressed: () {
                  updateMatkul();
                },
                child: Text("Simpan")),
          )
        ],
      ),
    );
    ;
  }
}
