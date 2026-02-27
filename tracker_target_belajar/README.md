# Aplikasi Tracker Target Belajar

## Deskripsi Aplikasi
Aplikasi Target Belajar adalah aplikasi mobile berbasis Flutter yang digunakan untuk mencatat dan mengelola target belajar. Pengguna dapat menambahkan target berdasarkan mata kuliah, mengelompokkan ke dalam folder/kategori, serta menandai target yang telah selesai.
Aplikasi ini dibuat untuk membantu mahasiswa dalam mengatur perencanaan belajar secara terstruktur dan terorganisir.

## 🚀 Fitur Aplikasi
- Menambahkan target belajar
- Mengedit (Update) data target
- Menghapus target
- Mengelompokkan target berdasarkan folder/kategori
- Menampilkan progres penyelesaian per folder
- Menandai target sebagai selesai/belum selesai
- Filter target berdasarkan folder
- Validasi form (tidak boleh kosong)

## 🧩 Widget yang Digunakan
Beberapa widget utama yang digunakan dalam aplikasi:
- `Scaffold`
- `AppBar`
- `ListView.builder`
- `Container`
- `Column`
- `Row`
- `Text`
- `TextField`
- `IconButton`
- `FloatingActionButton`
- `ElevatedButton`
- `GestureDetector`
- `SizedBox`

## Nilai Tambah
### 1. Update (Edit Data)
Aplikasi mendukung fitur update/edit data target.  
Ketika tombol dengan icon edit ditekan, data sebelumnya akan otomatis muncul kembali di form seperti saat pertama kali menginputkan data data di text field.

### 2. Multi Page Navigation
Aplikasi menggunakan navigasi multi halaman:
- HomePage
- FormPage
- FolderPage
Navigasi dilakukan menggunakan package `GetX` dengan `Get.to()` dan `Get.back()`.

## Teknologi yang Digunakan
- Flutter
- Dart
- GetX (Navigation & Snackbar)

## Developer
Dibuat sebagai tugas mini project Flutter.
