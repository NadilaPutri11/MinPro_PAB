import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/target_controller.dart';
import '../pages/form_page.dart';

class FolderPage extends StatefulWidget {
  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  final TargetController controller = Get.find();

  String? selectedFolder;

  bool showAll = true;
  bool showSelesai = true;

  String searchText = "";
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          showAll
              ? "Semua Target"
              : selectedFolder == null
                  ? "Folder"
                  : selectedFolder!,
        ),
        actions: [
          if (showAll)
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearchBox();
              },
            ),
          if (showAll)
            IconButton(
              icon: Icon(
                showSelesai ? Icons.check_circle : Icons.radio_button_unchecked,
              ),
              onPressed: () {
                setState(() {
                  showSelesai = !showSelesai;
                });
              },
            ),
          IconButton(
            icon: Icon(showAll ? Icons.folder : Icons.list),
            onPressed: () {
              setState(() {
                showAll = !showAll;
                selectedFolder = null;
              });
            },
          ),
        ],
        leading: !showAll && selectedFolder != null
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedFolder = null;
                  });
                },
              )
            : null,
      ),
      body: Obx(() {
        if (showAll) {
          var data = controller.targets.toList();
          if (searchText.isNotEmpty) {
            data = data
                .where((t) =>
                    t.mataKuliah.toLowerCase().contains(searchText) ||
                    t.target.toLowerCase().contains(searchText) ||
                    t.deskripsi.toLowerCase().contains(searchText))
                .toList();
          }

          if (!showSelesai) {
            data = data.where((t) => !t.selesai).toList();
          }

          if (data.isEmpty) {
            return Center(child: Text("Tidak ada target"));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (c, i) {
              final item = data[i];
              return Card(
                child: ExpansionTile(
                  leading: GestureDetector(
                    onTap: () => controller.toggleSelesai(item),
                    child: Icon(
                      item.selesai ? Icons.check_circle : Icons.circle_outlined,
                    ),
                  ),

                  title: Text(item.mataKuliah),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.target),
                      Text("Folder: ${item.kategori}"),
                      Text("Deadline: ${item.deadline.toString().split(" ")[0]}"),
                    ],
                  ),

                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.to(() => FormPage(target: item));
                    },
                  ),

                  children: [
                    if (item.deskripsi.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            item.deskripsi,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }

        if (selectedFolder == null) {
          final daftarFolder = controller.targets
              .map((e) => e.kategori)
              .toSet()
              .toList();

          if (daftarFolder.isEmpty) {
            return Center(child: Text("Belum ada folder"));
          }

          return ListView.builder(
            itemCount: daftarFolder.length,
            itemBuilder: (c, i) {
              final nama = daftarFolder[i];
              final isi =
                  controller.targets.where((t) => t.kategori == nama).toList();
              final selesai = isi.where((e) => e.selesai).length;

              return ListTile(
                leading: Icon(Icons.folder),
                title: Text(nama.isEmpty ? "Tanpa Folder" : nama),
                subtitle: Text("$selesai / ${isi.length} selesai"),
                onTap: () {
                  setState(() {
                    selectedFolder = nama;
                  });
                },
              );
            },
          );
        }

        final data =
            controller.targets.where((t) => t.kategori == selectedFolder).toList();
        if (data.isEmpty) {
          return Center(child: Text("Folder kosong"));
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (c, i) {
            final item = data[i];
            return Card(
              child: ListTile(
                leading: GestureDetector(
                  onTap: () => controller.toggleSelesai(item),
                  child: Icon(
                      item.selesai ? Icons.check_circle : Icons.circle_outlined),
                ),
                title: Text(item.mataKuliah),
                subtitle: Text(item.target),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Get.to(() => FormPage(target: item));
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void showSearchBox() {
    Get.defaultDialog(
      title: "Cari",
      content: TextField(
        controller: searchCtrl,
        decoration: InputDecoration(
          hintText: "Cari target...",
        ),
      ),
      textConfirm: "OK",
      onConfirm: () {
        setState(() {
          searchText = searchCtrl.text.toLowerCase();
        });
        Get.back();
      },
    );
  }
}

class TargetModel {
  final String id;
  final String kategori;
  final String mataKuliah;
  final String target;
  final DateTime deadline;
  final String deskripsi;
  final bool selesai;

  TargetModel({
    required this.id,
    required this.kategori,
    required this.mataKuliah,
    required this.target,
    required this.deadline,
    required this.deskripsi,
    required this.selesai,
  });

  factory TargetModel.fromMap(Map<String, dynamic> map) {
    return TargetModel(
      id: map['id']?.toString() ?? '',
      kategori: map['kategori'] ?? '',
      mataKuliah: map['mataKuliah'] ?? '',
      target: map['target'] ?? '',
      deadline: map['deadline'] != null
        ? DateTime.parse(map['deadline'])
        : DateTime.now(),
      deskripsi: map['deskripsi'] ?? '',
      selesai: map['selesai'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kategori': kategori,
      'mataKuliah': mataKuliah,
      'target': target,
      'deadline': deadline.toIso8601String(),
      'deskripsi': deskripsi,
      'selesai': selesai,
    };
  }

  TargetModel copyWith({
    String? id,
    String? kategori,
    String? mataKuliah,
    String? target,
    DateTime? deadline,
    String? deskripsi,
    bool? selesai,
  }) {
    return TargetModel(
      id: id ?? this.id,
      kategori: kategori ?? this.kategori,
      mataKuliah: mataKuliah ?? this.mataKuliah,
      target: target ?? this.target,
      deadline: deadline ?? this.deadline,
      deskripsi: deskripsi ?? this.deskripsi,
      selesai: selesai ?? this.selesai,
    );
  }
}