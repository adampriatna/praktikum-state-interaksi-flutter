import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const blue = Color(0xFF2147D0);
const purple = Color(0xFF7535E8);
const bg = Color(0xFFF0F4FF);
const ink = Color(0xFF14265E);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State dan Interaksi Pengguna',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
      ),
      home: const PraktikumPage(),
    );
  }
}

class PraktikumPage extends StatefulWidget {
  const PraktikumPage({super.key});

  @override
  State<PraktikumPage> createState() => _PraktikumPageState();
}

class _PraktikumPageState extends State<PraktikumPage> {
  int counter = 0;
  bool sudahBelajar = false;
  bool animasiAktif = false;
  String nama = '';
  Color warna = const Color(0xFF5367F5);
  double ukuran = 100;

  final namaController = TextEditingController();
  final tugasController = TextEditingController();

  final List<String> tugas = [
    'Mempelajari Flutter',
    'Mengerjakan praktikum',
    'Membuat laporan',
  ];

  final Set<String> selesai = {};

  @override
  void dispose() {
    namaController.dispose();
    tugasController.dispose();
    super.dispose();
  }

  void beriPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void tampilkanSapaan() {
    final input = namaController.text.trim();
    if (input.isEmpty) {
      beriPesan('Masukkan nama terlebih dahulu!');
      return;
    }
    setState(() => nama = input);
  }

  void tambahTugas() {
    final input = tugasController.text.trim();
    if (input.isEmpty) {
      beriPesan('Masukkan nama tugas terlebih dahulu!');
      return;
    }
    setState(() {
      tugas.add(input);
      tugasController.clear();
    });
  }

  Widget judul(
    String nomor,
    String teks,
    String deskripsi,
    IconData ikon,
    Color warnaIkon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: warnaIkon.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(ikon, color: warnaIkon, size: 25),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$nomor. $teks',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                deskripsi,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF607096),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget kartu({
    required String nomor,
    required String teks,
    required String deskripsi,
    required IconData ikon,
    required Color warnaIkon,
    required Widget isi,
  }) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shadowColor: blue.withValues(alpha: 0.10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
        color: Colors.black,
        width: 1.2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            judul(nomor, teks, deskripsi, ikon, warnaIkon),
            const SizedBox(height: 16),
            isi,
          ],
        ),
      ),
    );
  }

  Widget panel(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blue.withValues(alpha: 0.055),
            purple.withValues(alpha: 0.065),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD8E0F5),
          width: 1,
        )
      ),
      child: child,
    );
  }

  Widget counterCard() {
    return kartu(
      nomor: '1',
      teks: 'Counter dan setState',
      deskripsi: 'Mengubah nilai dan memperbarui UI',
      ikon: Icons.bar_chart_rounded,
      warnaIkon: blue,
      isi: panel(
        Column(
          children: [
            const Text('Nilai Counter', style: TextStyle(color: ink)),
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 58,
                fontWeight: FontWeight.bold,
                color: blue,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                FilledButton.icon(
                  onPressed: () => setState(() => counter++),
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                ),
                OutlinedButton.icon(
                  onPressed: () => setState(() => counter = 0),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inputCard() {
    return kartu(
      nomor: '2',
      teks: 'Input Pengguna',
      deskripsi: 'TextField dan fungsi callback',
      ikon: Icons.person_rounded,
      warnaIkon: purple,
      isi: Column(
        children: [
          TextField(
            controller: namaController,
            onSubmitted: (_) => tampilkanSapaan(),
            decoration: const InputDecoration(
              labelText: 'Nama mahasiswa',
              hintText: 'Masukkan nama Anda',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: purple,
              ),
              onPressed: tampilkanSapaan,
              icon: const Icon(Icons.send_rounded),
              label: const Text('Tampilkan Sapaan'),
            ),
          ),
          if (nama.isNotEmpty) ...[
            const SizedBox(height: 12),
            panel(
              Row(
                children: [
                  const Icon(
                    Icons.chat_bubble_rounded,
                    color: purple,
                    size: 30,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Halo, $nama!\nSelamat belajar Flutter!',
                      style: const TextStyle(
                        color: ink,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget checkboxCard() {
    return kartu(
      nomor: '3',
      teks: 'Checkbox Interaksi',
      deskripsi: 'Checkbox dan setState()',
      ikon: Icons.verified_rounded,
      warnaIkon: Colors.green,
      isi: panel(
        Column(
          children: [
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text(
                'Saya sudah belajar hari ini',
                style: TextStyle(fontSize: 13, color: ink),
              ),
              value: sudahBelajar,
              onChanged: (nilai) {
                setState(() => sudahBelajar = nilai ?? false);
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: sudahBelajar
                    ? Colors.green.shade100
                    : Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu_book, color: Colors.green),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      sudahBelajar
                          ? 'Status: Sudah belajar'
                          : 'Status: Belum belajar',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF167849),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget animasiCard() {
    return kartu(
      nomor: '4',
      teks: 'Animasi AnimatedContainer',
      deskripsi: 'Animasi ukuran dan warna',
      ikon: Icons.auto_awesome,
      warnaIkon: Colors.pink,
      isi: panel(
        Column(
          children: [
            GestureDetector(
              onTap: () => setState(() {
                animasiAktif = !animasiAktif;
              }),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 450),
                curve: Curves.easeInOut,
                width: animasiAktif ? 150 : 100,
                height: animasiAktif ? 115 : 95,
                decoration: BoxDecoration(
                  color: warna,
                  borderRadius: BorderRadius.circular(
                    animasiAktif ? 28 : 13,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: warna.withValues(alpha: 0.22),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: purple),
              onPressed: () => setState(() {
                animasiAktif = !animasiAktif;
              }),
              icon: const Icon(Icons.play_arrow),
              label: Text(
                animasiAktif ? 'Kembalikan Bentuk' : 'Jalankan Animasi',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget kontrolCard() {
    return kartu(
      nomor: '5',
      teks: 'Kontrol Tambahan',
      deskripsi: 'RadioButton, Slider, GestureDetector',
      ikon: Icons.tune_rounded,
      warnaIkon: Colors.orange,
      isi: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih warna kotak',
            style: TextStyle(
              color: ink,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            children: [
              pilihanWarna('Biru', const Color(0xFF5367F5)),
              pilihanWarna('Merah', const Color(0xFFEF5350)),
              pilihanWarna('Hijau', const Color(0xFF26A269)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Ukuran kotak: ${ukuran.round()}',
            style: const TextStyle(color: ink),
          ),
          Slider(
            value: ukuran,
            min: 60,
            max: 160,
            divisions: 10,
            label: ukuran.round().toString(),
            onChanged: (nilai) => setState(() => ukuran = nilai),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                warna = warna == blue ? purple : blue;
                animasiAktif = !animasiAktif;
              });
              beriPesan('Interaksi GestureDetector berhasil!');
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.touch_app, color: purple),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ketuk di sini untuk mengubah warna!',
                      style: TextStyle(fontSize: 12, color: ink),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: ukuran,
              height: ukuran,
              decoration: BoxDecoration(
                color: warna,
                borderRadius: BorderRadius.circular(
                  animasiAktif ? 28 : 12,
                ),
              ),
              child: const Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pilihanWarna(String label, Color nilai) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Color>(
          value: nilai,
          groupValue: warna,
          onChanged: (v) {
            if (v != null) setState(() => warna = v);
          },
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget daftarCard() {
    return kartu(
      nomor: '6',
      teks: 'Daftar Tugas Dinamis',
      deskripsi: 'Tambah, tandai selesai, dan hapus item menggunakan setState()',
      ikon: Icons.format_list_bulleted_rounded,
      warnaIkon: Colors.pink,
      isi: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: tugasController,
                  onSubmitted: (_) => tambahTugas(),
                  decoration: const InputDecoration(
                    hintText: 'Masukkan tugas baru...',
                    prefixIcon: Icon(Icons.list_alt),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: purple),
                onPressed: tambahTugas,
                icon: const Icon(Icons.add),
                label: const Text('Tambah Tugas'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '${tugas.length} tugas • ${selesai.length} selesai',
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 6),
          if (tugas.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Belum ada tugas. Tambahkan tugas baru!'),
            ),
          ...List.generate(tugas.length, (index) {
            final item = tugas[index];
            final dicentang = selesai.contains(item);

            return Container(
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFDCE3F8)),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: dicentang,
                    onChanged: (nilai) {
                      setState(() {
                        if (nilai == true) {
                          selesai.add(item);
                        } else {
                          selesai.remove(item);
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        color: ink,
                        decoration: dicentang
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Hapus tugas',
                    onPressed: () {
                      setState(() {
                        selesai.remove(item);
                        tugas.removeAt(index);
                      });
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final lebar = constraints.maxWidth;
            final padding = lebar < 600 ? 12.0 : 24.0;
            final jarak = lebar < 600 ? 10.0 : 14.0;
            final konten = lebar - padding * 2;

            // Layout 2 kartu atas, 3 kartu tengah pada layar lebar.
            final duaKolom = lebar >= 700;
            final tigaKolom = lebar >= 1100;
            final lebarAtas = duaKolom
                ? (konten - jarak) / 2
                : konten;
            final lebarTengah = tigaKolom
                ? (konten - jarak * 2) / 3
                : lebar >= 700
                    ? (konten - jarak) / 2
                    : konten;

            return SingleChildScrollView(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.all(lebar < 600 ? 18 : 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [blue, purple],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: purple.withValues(alpha: 0.18),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20,
                      runSpacing: 14,
                      children: [
                        SizedBox(
                          width: lebar < 600 ? konten - 36 : konten * 0.62,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.school_rounded,
                                color: Colors.white,
                                size: 34,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'State dan Interaksi Pengguna',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                'Belajar mengelola state, input, callback, '
                                'animasi, dan daftar dinamis dengan Flutter.',
                                style: TextStyle(
                                  color: Colors.white70,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.flutter_dash,
                                color: Colors.white,
                                size: 32,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Praktikum Flutter',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'StatefulWidget',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: jarak),

                  // Baris atas: dua kartu
                  Wrap(
                    spacing: jarak,
                    runSpacing: jarak,
                    children: [
                      SizedBox(width: lebarAtas, child: counterCard()),
                      SizedBox(width: lebarAtas, child: inputCard()),
                    ],
                  ),
                  SizedBox(height: jarak),

                  // Baris tengah: tiga kartu pada layar lebar
                  Wrap(
                    spacing: jarak,
                    runSpacing: jarak,
                    children: [
                      SizedBox(width: lebarTengah, child: checkboxCard()),
                      SizedBox(width: lebarTengah, child: animasiCard()),
                      SizedBox(width: lebarTengah, child: kontrolCard()),
                    ],
                  ),
                  SizedBox(height: jarak),

                  // Daftar tugas menggunakan seluruh lebar
                  daftarCard(),
                  const SizedBox(height: 16),
                  const Center(
                    child: Text(
                      'Praktikum Mobile Programming • Flutter',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}