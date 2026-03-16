# tracker_target_belajar_upgrade README.md

## Target Belajar App

Aplikasi **Target Belajar** adalah aplikasi mobile berbasis **Flutter** yang digunakan untuk mencatat dan mengelola target belajar mahasiswa.
Aplikasi ini memungkinkan pengguna untuk membuat target belajar berdasarkan mata kuliah, deadline, dan kategori folder.

Pada Mini Project 2 ini, aplikasi dikembangkan dengan **integrasi database Supabase** sehingga seluruh data target belajar disimpan secara online dan dapat dilakukan operasi **Create, Read, Update, dan Delete (CRUD)**.

# Fitur Aplikasi

## Manajemen Target Belajar (CRUD)

Aplikasi dapat melakukan operasi data berikut:

* **Create**
  Menambahkan target belajar baru ke database Supabase.

* **Read**
  Menampilkan daftar target belajar dari database Supabase.

* **Update**
  Mengedit data target belajar yang sudah dibuat.

* **Delete**
  Menghapus target belajar dari database Supabase.

## Kalender Deadline

Aplikasi menyediakan tampilan **kalender** untuk melihat target belajar berdasarkan tanggal deadline.

Fitur kalender:

* Mode **Bulan**
* Mode **Minggu**
* Pengelompokan target berdasarkan tanggal
* Label waktu seperti:

  * Hari ini
  * Besok
  * Lusa
  * x hari lagi

## Folder Target

Target belajar dapat dikelompokkan dalam **folder/kategori**.

Fitur folder:

* Melihat daftar folder
* Melihat jumlah target selesai dalam folder
* Menampilkan target berdasarkan folder

## Status Selesai Target

Setiap target memiliki status:

* Belum selesai
* Selesai

Target yang selesai akan:

* Ditandai dengan ikon ✔
* Teks menjadi **strikethrough**

## Pencarian Target

Pengguna dapat mencari target berdasarkan:

* Mata kuliah
* Target belajar
* Deskripsi

## Mode Tampilan (Light & Dark Mode)

Aplikasi mendukung:

* **Light Mode**
* **Dark Mode**

Tema disimpan menggunakan **SharedPreferences** sehingga tetap tersimpan saat aplikasi dibuka kembali.

# 🗄 Database

Aplikasi menggunakan **Supabase** sebagai backend database.

Tabel yang digunakan:

### Table: `targets`

| Field      | Type        | Keterangan         |
| ---------- | ----------- | ------------------ |
| id         | uuid /      | ID target          |
| kategori   | text        | Nama folder        |
| mataKuliah | text        | Mata kuliah        |
| target     | text        | Target belajar     |
| deadline   | date        | Deadline target    |
| deskripsi  | text        | Deskripsi tambahan |
| selesai    | boolean     | Status selesai     |

# 🧭 Navigasi Halaman

Aplikasi memiliki beberapa halaman utama:

1️⃣ **Home Page**

* Menampilkan target berdasarkan kalender
* Toggle kalender bulan / minggu
* Menampilkan target belum selesai dan selesai

2️⃣ **Form Page**

Digunakan untuk:

* Menambah target
* Mengedit target

Field input:

* Folder
* Mata Kuliah
* Target Belajar
* Deadline
* Deskripsi

3️⃣ **Folder Page**

Menampilkan:

* Daftar folder
* Target dalam folder
* Progress target selesai

4️⃣ **Main Navigation**

Navigasi menggunakan:

* Bottom Navigation Bar
* Floating Action Button untuk menambah target

# Widget yang Digunakan

Beberapa widget utama yang digunakan dalam aplikasi:

### Layout Widget

* `Scaffold`
* `AppBar`
* `Column`
* `Row`
* `Expanded`
* `Padding`
* `Card`
* `ListView`
* `ListTile`

### Input Widget

* `TextField`
* `DropdownButtonFormField`
* `ElevatedButton`
* `showDatePicker`

### Navigasi

* `GetMaterialApp`
* `GetPage`
* `Get.to()`
* `Get.until()`

### UI Widget

* `ExpansionTile`
* `TableCalendar`
* `FloatingActionButton`
* `BottomAppBar`
* `ToggleButtons`
* `IconButton`

# Teknologi yang Digunakan

* **Flutter**
* **GetX** (State Management & Navigation)
* **Supabase**
* **SharedPreferences**
* **Table Calendar**
* **dotenv**

# Environment Variable

Aplikasi menggunakan file `.env` untuk menyimpan konfigurasi Supabase.

Contoh `.env`:

```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_key
```

File `.env` **tidak disertakan dalam repository GitHub** untuk menjaga keamanan API key.

---

# Struktur Folder (Simplified)

```
lib
 ┣ controllers
 ┃ ┗ target_controller.dart
 ┣ models
 ┃ ┗ target_model.dart
 ┣ pages
 ┃ ┣ home_page.dart
 ┃ ┣ form_page.dart
 ┃ ┣ folder_page.dart
 ┃ ┗ main_nav_page.dart
 ┣ routes
 ┃ ┗ app_pages.dart
 ┣ services
 ┃ ┗ supabase_service.dart
 ┣ themes
 ┃ ┗ theme_controller.dart
 ┗ main.dart
```

---

# 🚀 Cara Menjalankan Aplikasi

1️⃣ Clone repository

```
git clone <link repository>
```

2️⃣ Install dependency

```
flutter pub get
```

3️⃣ Tambahkan file `.env`

4️⃣ Jalankan aplikasi

```
flutter run
```

---

# Fitur Tambahan yang diimplementasikan
✔ **Folder Management**

✔ **Kalender Deadline**

✔ **Search Target**

✔ **Grouping Target by Date**

# Nilai Tambah yang Diimplementasikan

Berikut fitur tambahan yang diimplementasikan dalam aplikasi:

✔ **Light Mode & Dark Mode**

✔ **Environment Variable (.env)** untuk menyimpan Supabase URL dan API Key

# 📌 Repository

Repository GitHub:

```
<masukkan link repo kamu di sini>
```

# 📊 Sekarang kita cek tugasmu

## ✅ Ketentuan Umum

| Ketentuan                    | Status |
| ---------------------------- | ------ |
| Flutter App                  | ✅      |
| Lanjutan Mini Project 1      | ✅      |
| Integrasi Supabase           | ✅      |
| Struktur aplikasi lebih rapi | ✅      |

## ✅ Fitur Wajib

| Fitur                 | Status      |
| --------------------- | ----------- |
| Create                | ✅           |
| Read                  | ✅           |
| Update                | ✅           |
| Delete                | ✅           |
| Halaman List Data     | ✅           |
| Halaman Form          | ✅           |
| Minimal 3 field input | ✅ (5 field) |
| Data dari Supabase    | ✅           |

## ⭐ Nilai Tambah

| Nilai Tambah    | Status |
| --------------- | ------ |
| Login Register  | ❌      |
| Light/Dark Mode | ✅      |
| .env            | ✅      |