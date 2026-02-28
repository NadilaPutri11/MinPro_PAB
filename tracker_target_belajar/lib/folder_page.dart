import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FolderPage extends StatelessWidget {
  final List<Map<String, String>> dataTarget;

  const FolderPage({super.key, required this.dataTarget});

  @override
  Widget build(BuildContext context) {

    final daftarFolder = dataTarget
        .map((data) => data['kategori'] as String)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Folder"),
      ),
      body: ListView.builder(
        itemCount: daftarFolder.length,
        itemBuilder: (context, index) {
          final namaFolder = daftarFolder[index];
          final isiFolder = dataTarget
              .where((data) => data['kategori'] == namaFolder)
              .toList();
          final total = isiFolder.length;
          final selesai = isiFolder
              .where((data) => data['isDone'] == 'true')
              .length;
          final persen = total == 0 ? 0 : ((selesai / total) * 100).round();
          final semuaSelesai = total > 0 && selesai == total;
          return ListTile(
            leading: const Icon(Icons.folder),
            title: Text(namaFolder),
            subtitle: semuaSelesai
                ? const Text("Semua target belajar telah terpenuhi ✅")
                : Text("$selesai dari $total selesai ($persen%)"),
            onTap: () {
              Get.back(result: namaFolder);
            },
          );
        },
      ),
    );
  }
}
