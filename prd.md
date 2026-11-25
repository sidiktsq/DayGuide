# PRODUCT REQUIREMENTS DOCUMENT (PRD)
## DAYGUIDE — Small Guides, Better Everyday

**Version:** 1.0  
**Platform:** Android  
**Framework:** Flutter  
**Design System:** Modern Neobrutalism

---

## 1. Product Overview

DAYGUIDE adalah aplikasi panduan kehidupan sehari-hari yang menyediakan informasi praktis, tutorial, dan langkah-langkah sederhana untuk membantu pengguna menyelesaikan berbagai kebutuhan sehari-hari.

Aplikasi dirancang agar mudah digunakan oleh semua kalangan usia dengan tampilan modern, navigasi sederhana, dan konten yang mudah dipahami.

## 2. Product Goals

- Memberikan akses mudah terhadap panduan praktis.
- Membantu pengguna memperoleh informasi yang bermanfaat.
- Menyediakan panduan yang terstruktur dan mudah diikuti.
- Memungkinkan pengguna menyimpan panduan favorit.
- Mendukung penggunaan tanpa koneksi internet.

## 3. Target Users

- Pelajar dan mahasiswa.
- Pekerja.
- Orang tua.
- Masyarakat umum.
- Pengguna yang membutuhkan informasi praktis.

## 4. Core Features

### 4.1 Home Dashboard
- Greeting pengguna.
- Search bar.
- Featured guides.
- Popular guides.
- Category shortcuts.
- Recently added guides.

### 4.2 Explore Categories
- Menampilkan seluruh kategori.
- Menampilkan jumlah panduan.
- Filter berdasarkan kategori.
- Membuka daftar panduan dalam kategori.

### 4.3 Guide Detail
- Judul panduan.
- Deskripsi.
- Thumbnail atau ilustrasi.
- Estimasi waktu membaca.
- Tingkat kesulitan.
- Daftar langkah-langkah.
- Sumber informasi.
- Tombol bookmark.

### 4.4 Search
- Pencarian berdasarkan judul.
- Pencarian berdasarkan kata kunci.
- Filter kategori.
- Empty search state.

### 4.5 Bookmark
- Menyimpan panduan favorit.
- Menghapus bookmark.
- Menampilkan panduan tersimpan.
- Data tetap tersedia setelah aplikasi ditutup.

### 4.6 Reading History
- Menyimpan panduan yang pernah dibuka.
- Menampilkan waktu terakhir dibaca.
- Menampilkan progres membaca jika tersedia.

### 4.7 Profile & Settings
- Profil lokal pengguna.
- Pengaturan tema.
- Informasi aplikasi.
- Kebijakan privasi.
- Versi aplikasi.

## 5. Main Navigation

Bottom Navigation terdiri dari:

1. Home
2. Explore
3. Saved
4. Profile

Search dapat diakses dari Home dan Explore.

## 6. Content Categories

Kategori awal yang direkomendasikan:

- Daily Life
- Technology
- Education
- Health & Wellness
- Finance
- Environment
- Home & Living
- Safety

## 7. Design Requirements

Menggunakan Modern Neobrutalism dengan karakteristik:

- Background warm cream.
- Bold typography.
- Thick black borders.
- Hard offset shadows.
- Bright yellow primary accent.
- Colorful category cards.
- Rounded corners yang konsisten.
- Clear visual hierarchy.
- Simple and intuitive navigation.

## 8. Technical Requirements

Frontend:
- Flutter
- Dart
- Material Design components yang dikustomisasi.

State Management:
- Provider.

Local Database:
- SQLite menggunakan sqflite.

Architecture:
- Feature-based folder structure.
- Separation of UI, models, services, and repositories.

Internet:
- Konten panduan awal dapat tersedia secara lokal.
- REST API dapat ditambahkan untuk pembaruan konten.

## 9. Non-Functional Requirements

- Aplikasi harus ringan dan responsif.
- Navigasi mudah dipahami.
- Mendukung berbagai ukuran layar Android.
- Data bookmark harus tersimpan secara permanen.
- Tampilan konsisten di seluruh halaman.
- Informasi harus memiliki sumber yang jelas.
- Tidak membutuhkan koneksi internet untuk fitur inti.

## 10. MVP Scope

Fitur yang wajib tersedia pada versi pertama:

- Home Dashboard.
- Explore Categories.
- Guide Detail.
- Search.
- Bookmark.
- Reading History.
- Profile & Settings.

Fitur yang belum menjadi prioritas:
- Login dan registrasi.
- Komunitas pengguna.
- Chat.
- Upload panduan oleh pengguna.
- Sinkronisasi cloud.

## 11. Success Criteria

Versi pertama dianggap berhasil apabila:

- Seluruh halaman utama dapat diakses.
- Pengguna dapat mencari panduan.
- Pengguna dapat membaca panduan.
- Pengguna dapat menyimpan dan menghapus bookmark.
- Bookmark tetap tersimpan setelah aplikasi dibuka kembali.
- Aplikasi dapat digunakan tanpa koneksi internet untuk konten lokal.

## 12. Product Direction

DAYGUIDE dikembangkan sebagai aplikasi panduan praktis yang mengutamakan kemudahan, kejelasan informasi, performa, dan manfaat nyata bagi pengguna.