import 'package:sqflite/sqflite.dart';

class SeedData {
  static List<Map<String, dynamic>> getInitialCategories() {
    return [
      {
        'id': 1,
        'name': 'Kehidupan Sehari-hari',
        'description': 'Tips praktis rutinitas harian & rumah tangga',
        'icon': 'cottage',
        'color': '#6EE7B7', // Mint
      },
      {
        'id': 2,
        'name': 'Teknologi & Gadget',
        'description': 'Gadget, aplikasi, trik software & komputer',
        'icon': 'devices',
        'color': '#8CCBFF', // Sky Blue
      },
      {
        'id': 3,
        'name': 'Keuangan Pribadi',
        'description': 'Budgeting, hemat, investasi & perbankan',
        'icon': 'payments',
        'color': '#FFD84D', // Sunshine Yellow
      },
      {
        'id': 4,
        'name': 'Kesehatan & Kebugaran',
        'description': 'Pola makan, tidur, olahraga & kebugaran',
        'icon': 'health_and_safety',
        'color': '#FF8066', // Coral
      },
      {
        'id': 5,
        'name': 'Rumah & Hunian',
        'description': 'Perbaikan rumah, dekorasi & kebersihan DIY',
        'icon': 'home',
        'color': '#C4B5FD', // Soft Lavender
      },
      {
        'id': 6,
        'name': 'Lingkungan Hidup',
        'description': 'Zero waste, pemilahan sampah & daur ulang',
        'icon': 'recycling',
        'color': '#A7F3D0', // Pale Green
      },
      {
        'id': 7,
        'name': 'Pendidikan & Karir',
        'description': 'Belajar teratur, skill produktivitas & karir',
        'icon': 'school',
        'color': '#FDE047', // Soft Yellow
      },
      {
        'id': 8,
        'name': 'Keselamatan & Darurat',
        'description': 'Pertolongan pertama (P3K) & nomor darurat',
        'icon': 'security',
        'color': '#FCA5A5', // Soft Red
      },
    ];
  }

  static List<Map<String, dynamic>> getInitialGuides() {
    final now = DateTime.now().toIso8601String();
    return [
      {
        'id': 1,
        'category_id': 3, // Keuangan
        'title': 'Cara Mengatur Keuangan Bulanan dengan Metode 50/30/20',
        'description': 'Kendalikan arus kas pribadi dengan membagi pemasukan bersih menjadi 50% kebutuhan pokok, 30% keinginan, dan 20% tabungan/investasi.',
        'thumbnail': 'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?w=500&q=80',
        'difficulty': 'Pemula',
        'estimated_minutes': 5,
        'source': 'Otoritas Jasa Keuangan (OJK) & Perencana Keuangan Independen',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 2,
        'category_id': 2, // Teknologi
        'title': 'Cara Merawat Laptop dengan Benar agar Tahan 5 Tahun',
        'description': 'Kebiasaan sepele seperti meletakkan di kasur dan jarang membersihkan debu/thermal paste bisa memperpendek usia komponen laptopmu.',
        'thumbnail': 'https://images.unsplash.com/photo-1588872657578-7efd1f1555ed?w=500&q=80',
        'difficulty': 'Pemula',
        'estimated_minutes': 7,
        'source': 'Teknisi Komputer Profesional & Asosiasi Servis Elektronik',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 3,
        'category_id': 1, // Kehidupan Sehari-hari / Dokumen
        'title': 'Panduan Mengurus KTP & KK yang Hilang Tanpa Ribet',
        'description': 'Langkah demi langkah melapor ke kantor kepolisian terdekat hingga pencetakan ulang via kantor Dukcapil online maupun offline.',
        'thumbnail': 'https://images.unsplash.com/photo-1589829545856-d10d557cf95f?w=500&q=80',
        'difficulty': 'Menengah',
        'estimated_minutes': 6,
        'source': 'Ditjen Kependudukan dan Pencatatan Sipil (Dukcapil)',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 4,
        'category_id': 6, // Lingkungan
        'title': 'Cara Memilah Sampah Rumah Tangga Sistem 3 Bak',
        'description': 'Pisahkan sampah organik, anorganik yang bisa didaur ulang, dan residu B3 agar lingkungan tempat tinggal higienis dan ramah bumi.',
        'thumbnail': 'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=500&q=80',
        'difficulty': 'Sangat Mudah',
        'estimated_minutes': 4,
        'source': 'Kementerian Lingkungan Hidup dan Kehutanan (KLHK)',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 5,
        'category_id': 1, // Kehidupan Sehari-hari
        'title': 'Cara Mengatur Waktu dengan Metode Pomodoro & Time Boxing',
        'description': 'Fokus kerja 25 menit diselingi jeda istirahat 5 menit untuk meningkatkan produktivitas tanpa risiko burnout cepat lelah.',
        'thumbnail': 'https://images.unsplash.com/photo-1499750310107-5fef28a66643?w=500&q=80',
        'difficulty': 'Pemula',
        'estimated_minutes': 4,
        'source': 'Jurnal Psikologi Produktivitas & Manajemen Waktu',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 6,
        'category_id': 1, // Kehidupan Sehari-hari
        'title': 'Panduan Meal Prep Hemat untuk 1 Minggu Penuh',
        'description': 'Perencanaan belanja bahan mentah, teknik penyimpanan wadah kedap udara, dan memasak efisien untuk menghemat pengeluaran makan mingguan.',
        'thumbnail': 'https://images.unsplash.com/photo-1547592180-85f173990554?w=500&q=80',
        'difficulty': 'Menengah',
        'estimated_minutes': 8,
        'source': 'Panduan Ahli Gizi Komunitas & Food Planner',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 7,
        'category_id': 1, // Kehidupan Sehari-hari
        'title': 'Cara Menghilangkan Noda Pakaian Membandel Tanpa Rusak Serat',
        'description': 'Trik ampuh membersihkan noda minyak, kopi, darah, dan tinta pulpen menggunakan bahan dapur alami seperti soda kue dan cuka.',
        'thumbnail': 'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=500&q=80',
        'difficulty': 'Sangat Mudah',
        'estimated_minutes': 3,
        'source': 'Panduan Perawatan Tekstil & Laundry Ramah Lingkungan',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 8,
        'category_id': 4, // Kesehatan
        'title': 'Teknik Membangun Kebiasaan Bangun Pagi Tanpa Mengantuk',
        'description': 'Perbaiki ritme sirkadian tubuh dengan paparan sinar matahari pagi, jadwal tidur konsisten, dan menghindari layar sebelum tidur.',
        'thumbnail': 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=500&q=80',
        'difficulty': 'Pemula',
        'estimated_minutes': 6,
        'source': 'Yayasan Kesehatan Tidur & Konsultan Pola Hidup Sehat',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 9,
        'category_id': 3, // Keuangan
        'title': 'Cara Memulai Dana Darurat untuk Pemula',
        'description': 'Mengapa dana darurat 3-6 kali pengeluaran bulanan sangat vital dan cara mengumpulkannya sedikit demi sedikit secara konsisten.',
        'thumbnail': 'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?w=500&q=80',
        'difficulty': 'Pemula',
        'estimated_minutes': 4,
        'source': 'Perencana Keuangan Bersertifikat (CFP)',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 10,
        'category_id': 3, // Keuangan
        'title': 'Tips Berhemat Belanja Mingguan di Supermarket Tanpa Rugi',
        'description': 'Jangan lapar saat belanja, selalu bawa daftar belanja tertulis, bandingkan harga per unit, dan manfaatkan program loyalitas toko.',
        'thumbnail': 'https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=500&q=80',
        'difficulty': 'Mudah',
        'estimated_minutes': 4,
        'source': 'Komunitas Konsumen Cerdas Indonesia',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 11,
        'category_id': 3, // Keuangan
        'title': 'Membuat Rekening Tabungan Terpisah Tanpa Biaya Admin',
        'description': 'Komparasi bank digital terpercaya yang menawarkan pos rekening terpisah dengan biaya administrasi Rp 0 dan bunga kompetitif.',
        'thumbnail': 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=500&q=80',
        'difficulty': 'Menengah',
        'estimated_minutes': 6,
        'source': 'Lembaga Penjamin Simpanan (LPS) & Bank Indonesia',
        'created_at': now,
        'updated_at': now,
      },
      {
        'id': 12,
        'category_id': 8, // Keselamatan
        'title': 'Pertolongan Pertama pada Luka Bakar Ringan di Rumah',
        'description': 'Langkah cepat dan tepat mendinginkan luka dengan air mengalir suhu ruang selama 10-15 menit dan hindari penggunaan pasta gigi.',
        'thumbnail': 'https://images.unsplash.com/photo-1584515979956-d9f6e5d09982?w=500&q=80',
        'difficulty': 'Sangat Mudah',
        'estimated_minutes': 5,
        'source': 'Palang Merah Indonesia (PMI) & Kementerian Kesehatan RI',
        'created_at': now,
        'updated_at': now,
      },
    ];
  }

  static List<Map<String, dynamic>> getInitialSteps() {
    return [
      // Steps Guide 1
      {
        'id': 1,
        'guide_id': 1,
        'step_number': 1,
        'title': 'Hitung Total Penghasilan Bersih (Take Home Pay)',
        'content': 'Hitung seluruh pemasukan bulanan setelah dipotong pajak, iuran BPJS Kesehatan/Ketenagakerjaan, serta potongan wajib lainnya. Contoh jika take home pay Anda Rp 6.000.000, angka ini yang menjadi basis formula.',
        'image': null,
      },
      {
        'id': 2,
        'guide_id': 1,
        'step_number': 2,
        'title': 'Alokasikan 50% untuk Kebutuhan Pokok (Needs)',
        'content': 'Maksimal Rp 3.000.000 untuk pengeluaran esensial yang mutlak dibutuhkan agar kehidupan harianmu tetap berjalan aman: sewa kos/cicilan, belanja makan pokok, listrik, air, dan transportasi kerja.',
        'image': null,
      },
      {
        'id': 3,
        'guide_id': 1,
        'step_number': 3,
        'title': 'Sisihkan 20% untuk Tabungan (Pay Yourself First)',
        'content': 'Tepat saat gajian masuk, langsung alihkan Rp 1.200.000 ke rekening dana darurat atau reksadana pasar uang sebelum membelanjakan untuk hal-hal konsumtif.',
        'image': null,
      },
      {
        'id': 4,
        'guide_id': 1,
        'step_number': 4,
        'title': 'Gunakan 30% untuk Keinginan & Hiburan (Wants)',
        'content': 'Sisa dana sebesar Rp 1.800.000 dapat dinikmati tanpa rasa bersalah (guilt-free spending) untuk menjaga kesehatan mental, hobi, nongkrong akhir pekan, atau langganan streaming.',
        'image': null,
      },
      // Steps Guide 2
      {
        'id': 5,
        'guide_id': 2,
        'step_number': 1,
        'title': 'Gunakan Cooling Pad & Jangan Taruh di Atas Kasur',
        'content': 'Kasur atau selimut dapat menyerap panas dan menyumbat kisi-kisi ventilasi kipas laptop sehingga suhu prosesor melonjak tinggi.',
        'image': null,
      },
      {
        'id': 6,
        'guide_id': 2,
        'step_number': 2,
        'title': 'Atur Pola Pengisian Baterai (Batas 80%)',
        'content': 'Manfaatkan fitur Battery Limiter bawaan merk laptopmu agar baterai berhenti mengisi saat mencapai 80% guna memperpanjang siklus baterai.',
        'image': null,
      },
      {
        'id': 7,
        'guide_id': 2,
        'step_number': 3,
        'title': 'Bersihkan Debu Ventilasi Secara Rutin',
        'content': 'Semprot lubang sirkulasi udara dengan blower udara kecil tiap 3 bulan sekali untuk membuang gumpalan debu yang menyumbat heatsink.',
        'image': null,
      },
      {
        'id': 8,
        'guide_id': 2,
        'step_number': 4,
        'title': 'Ganti Thermal Paste Setiap 1-2 Tahun',
        'content': 'Pasta pendingin pada CPU/GPU akan mengering seiring waktu. Ganti dengan thermal paste berkualitas tinggi agar suhu tetap sejuk.',
        'image': null,
      },
      // Steps Guide 3
      {
        'id': 9,
        'guide_id': 3,
        'step_number': 1,
        'title': 'Buat Surat Keterangan Kehilangan di Polsek',
        'content': 'Datangi Polsek setempat di bagian SPKT dengan membawa fotokopi KTP/KK lama jika ada, atau sebutkan NIK kependudukan Anda.',
        'image': null,
      },
      {
        'id': 10,
        'guide_id': 3,
        'step_number': 2,
        'title': 'Minta Surat Pengantar RT/RW (Jika Diperlukan)',
        'content': 'Sebagian daerah kini tidak lagi mewajibkan pengantar RT/RW untuk pencetakan ulang KTP, namun tetap siapkan salinan berkas pendukung.',
        'image': null,
      },
      {
        'id': 11,
        'guide_id': 3,
        'step_number': 3,
        'title': 'Akses Aplikasi Layanan Dukcapil Online atau Datang Langsung',
        'content': 'Ajukan pencetakan ulang melalui aplikasi resmi Dukcapil daerah Anda (seperti Alpukat Betawi di DKI Jakarta) atau datangi mesin ADM terdekat.',
        'image': null,
      },
      // Steps Guide 4
      {
        'id': 12,
        'guide_id': 4,
        'step_number': 1,
        'title': 'Siapkan 3 Tempat Sampah dengan Label Warna Berbeda',
        'content': 'Gunakan warna Hijau untuk Organik, Kuning untuk Anorganik Daur Ulang, dan Abu-abu/Merah untuk Residu dan B3 rumah tangga.',
        'image': null,
      },
      {
        'id': 13,
        'guide_id': 4,
        'step_number': 2,
        'title': 'Kelompokkan Sampah Organik & Buat Kompos',
        'content': 'Sisa sayur, kulit buah, dan daun dapat diolah menjadi pupuk kompos atau pakan maggot tanpa menimbulkan bau busuk.',
        'image': null,
      },
      {
        'id': 14,
        'guide_id': 4,
        'step_number': 3,
        'title': 'Cuci & Keringkan Sampah Plastik Sebelum Disetor ke Bank Sampah',
        'content': 'Botol plastik dan kaleng minuman yang bersih memiliki nilai jual lebih tinggi dan siap diproses di pabrik daur ulang.',
        'image': null,
      },
    ];
  }

  static List<Map<String, dynamic>> getInitialBookmarks() {
    // Akun baru mulai dari kosong (0 tersimpan)
    return [];
  }

  static List<Map<String, dynamic>> getInitialHistory() {
    // Akun baru mulai dari kosong (0 terbaca)
    return [];
  }

  static Future<void> insertInitialData(Database db) async {
    for (final cat in getInitialCategories()) {
      await db.insert('CATEGORIES', cat);
    }
    for (final guide in getInitialGuides()) {
      await db.insert('GUIDES', guide);
    }
    for (final step in getInitialSteps()) {
      await db.insert('GUIDE_STEPS', step);
    }
    for (final bookmark in getInitialBookmarks()) {
      await db.insert('BOOKMARKS', bookmark);
    }
    for (final history in getInitialHistory()) {
      await db.insert('READING_HISTORY', history);
    }
  }
}
