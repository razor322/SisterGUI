import 'dart:convert';
//gybran nauval yuhandika 2111081006
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sister/const.dart';
import 'package:sister/mhs/mahasiswa_add.dart';
import 'package:sister/mhs/mahasiswa_update.dart';
import 'package:sister/nilai/nilai_mhs.dart';

class MahasiswaList extends StatefulWidget {
  const MahasiswaList({super.key});

  @override
  State<MahasiswaList> createState() => _MahasiswaList();
}

class _MahasiswaList extends State<MahasiswaList> {
  List listMahasiswa = [];
  List<dynamic> listMhs = [];

  @override
  void initState() {
    allMahasiswa();
    super.initState();
  }

  Future<void> allMahasiswa() async {
    String urlMahasiswa = "$url_mhs/api/v1/mahasiswa";
    try {
      var response = await http.get(Uri.parse(urlMahasiswa));
      listMahasiswa = jsonDecode(response.body);
      setState(() {
        listMahasiswa = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteMahasiwa(int id) async {
    String urlMahasiswa = "http://192.168.56.1:9001/api/v1/mahasiswa/${id}";
    try {
      await http.delete(Uri.parse(urlMahasiswa));
      setState(() {
        allMahasiswa();
      });
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const MahasiswaAdd()));
        },
        child: const Icon(
          CupertinoIcons.add,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Data Mahasiswa",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: listMahasiswa.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.deepPurple.shade50,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.blue.shade500,
                  size: 24,
                ),
                title: Text(
                  listMahasiswa[index]["nama"]?.toString() ?? "",
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${listMahasiswa[index]["email"]?.toString() ?? ""}\n${listMahasiswa[index]["tglLahir"]?.toString() ?? ""}",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.normal),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        tooltip: "Hapus Data",
                        onPressed: () {
                          deleteMahasiwa(listMahasiswa[index]["id"]);
                        },
                        icon: Icon(
                          CupertinoIcons.delete_right,
                          color: Colors.red.shade300,
                          size: 24,
                        )),
                    IconButton(
                        tooltip: "Edit Data",
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return MahasiswaUpdate(
                                idup: listMahasiswa[index]["id"],
                                namaup: listMahasiswa[index]["nama"],
                                emailup: listMahasiswa[index]["email"],
                                tglLahirup: DateTime.parse(
                                    listMahasiswa[index]["tglLahir"]),
                              );
                            }),
                          ).then((value) => allMahasiswa());
                        },
                        icon: Icon(
                          CupertinoIcons.pencil,
                          color: Colors.yellow.shade800,
                          size: 30,
                        )),
                    IconButton(
                        tooltip: "Lihat Nilai",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NilaiMahasiswa(
                                      listMahasiswa[index]["id"])));
                        },
                        icon: Icon(
                          // CupertinoIcons.arrowshape_turn_up_right_circle_fill,
                          CupertinoIcons.info_circle,
                          color: Colors.blue.shade300,
                          size: 28,
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
