import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_parsing/path_parsing.dart';
import 'package:qr_flutter/qr_flutter.dart';

const _purple = Color(0xFF4941D7);
const _violet = Color(0xFFB968E8);
const _ink = Color(0xFF29283C);
const _muted = Color(0xFF8B8A98);
const _background = Color(0xFFF5F5FC);

void main() {
  runApp(const LmsApp());
}

class LmsApp extends StatelessWidget {
  const LmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LMS Student',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _purple),
        scaffoldBackgroundColor: _background,
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // Empty fields intentionally do nothing: the form stays quiet until filled.
    if (username.isEmpty || password.isEmpty) return;

    if (username == 'admin' && password == 'asdf1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const TeacherHomePage()),
      );
      return;
    }

    if (username == 'user' && password == 'asdf1234') {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Username atau password belum sesuai.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_purple, _violet],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Bantuan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Center(
                            child: Text(
                              'LMS Student',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(20, 27, 20, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: _purple.withValues(alpha: .12),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Selamat Datang Kembali',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Masuk untuk melanjutkan aktivitas akademikmu',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _muted, fontSize: 12),
                        ),
                        const SizedBox(height: 24),
                        _InputField(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 14),
                        _InputField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          suffix: IconButton(
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: _muted,
                              size: 20,
                            ),
                          ),
                          onSubmitted: (_) => _signIn(),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _signIn,
                            style: FilledButton.styleFrom(
                              backgroundColor: _purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Masuk',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Lupa password?',
                            style: TextStyle(color: _purple, fontSize: 12),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Belum punya akun?',
                              style: TextStyle(color: _muted, fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              ),
                              child: const Text(
                                'Daftar',
                                style: TextStyle(color: _purple, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.label,
    required this.icon,
    this.obscureText = false,
    this.suffix,
    this.onSubmitted,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffix;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: onSubmitted == null
          ? TextInputAction.next
          : TextInputAction.done,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: _muted),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFFFAFAFD),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8E7F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8E7F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _purple, width: 1.4),
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _register() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _showMessage('Semua kolom wajib diisi.');
      return;
    }

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      _showMessage('Format email belum benar.');
      return;
    }

    if (password.length < 8) {
      _showMessage('Password minimal 8 karakter.');
      return;
    }

    if (password != confirmPassword) {
      _showMessage('Konfirmasi password belum sama.');
      return;
    }

    _showMessage('Pendaftaran berhasil. Silakan masuk.');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [_purple, _violet],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 66),
                          Center(
                            child: Text(
                              'LMS Student',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(20, 27, 20, 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: _purple.withValues(alpha: .12),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Buat Akun Baru',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Daftar untuk mulai mengikuti aktivitas akademikmu',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _muted, fontSize: 12),
                        ),
                        const SizedBox(height: 24),
                        _InputField(
                          controller: _usernameController,
                          label: 'Username',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 14),
                        _InputField(
                          controller: _emailController,
                          label: 'Email',
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 14),
                        _InputField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscurePassword,
                          suffix: IconButton(
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: _muted,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        _InputField(
                          controller: _confirmPasswordController,
                          label: 'Konfirmasi Password',
                          icon: Icons.lock_outline,
                          obscureText: _obscureConfirmPassword,
                          suffix: IconButton(
                            onPressed: () => setState(
                              () => _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                            ),
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: _muted,
                              size: 20,
                            ),
                          ),
                          onSubmitted: (_) => _register(),
                        ),
                        const SizedBox(height: 22),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: FilledButton(
                            onPressed: _register,
                            style: FilledButton.styleFrom(
                              backgroundColor: _purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Sudah punya akun?',
                              style: TextStyle(color: _muted, fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                'Masuk',
                                style: TextStyle(color: _purple, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _selectTab(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _Dashboard(onMenuTap: _handleDashboardMenu),
          const ExplorePage(),
          const ClassroomPage(),
          const ChatPage(),
          const AccountPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        backgroundColor: Colors.white,
        indicatorColor: _purple.withValues(alpha: .12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Jelajah',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Kelas',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Pesan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }

  void _handleDashboardMenu(String label) {
    if (label == 'Class Room') {
      setState(() => _selectedIndex = 2);
      return;
    }
    if (label == 'Belajar Kanji') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const KanjiLearningPage()));
      return;
    }
    if (label == 'Presensi QR') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const PresensiQrPage()));
      return;
    }
    if (label == 'Kartu Mahasiswa') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const KartuMahasiswaPage()));
      return;
    }
    if (label == 'Pembayaran') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const PembayaranPage()));
      return;
    }
    if (label == 'Mata Kuliah') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const MataKuliahPage()));
      return;
    }
    if (label == 'Hasil Ujian') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const HasilUjianPage()));
      return;
    }
    if (label == 'Tugas') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const TugasPage()));
      return;
    }
    if (label == 'Konsultasi') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const KonsultasiPage()));
      return;
    }
    if (label == 'Transkrip') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const TranskripPage()));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label dibuka'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 900),
      ),
    );
  }
}

class _Dashboard extends StatelessWidget {
  const _Dashboard({required this.onMenuTap});

  final ValueChanged<String> onMenuTap;

  @override
  Widget build(BuildContext context) {
    final menu = [
      (Icons.qr_code_scanner_rounded, 'Presensi QR', const Color(0xFFE0F5EA)),
      (Icons.badge_outlined, 'Kartu Mahasiswa', const Color(0xFFFFEBC9)),
      (Icons.receipt_long_outlined, 'Pembayaran', const Color(0xFFE0F5F5)),
      (Icons.menu_book_outlined, 'Mata Kuliah', const Color(0xFFE0F5EA)),
      (Icons.assignment_outlined, 'Hasil Ujian', const Color(0xFFE0F5EA)),
      (Icons.edit_note, 'Tugas', const Color(0xFFE0F5EA)),
      (Icons.support_agent, 'Konsultasi', const Color(0xFFE0F5EA)),
      (Icons.workspace_premium_outlined, 'Transkrip', const Color(0xFFFFEBC9)),
      (Icons.groups_outlined, 'Class Room', const Color(0xFFE5E1FF)),
      (Icons.draw_outlined, 'Belajar Kanji', const Color(0xFFFFE1EC)),
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_purple, _violet],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Text(
                          'LM',
                          style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, lulu malik',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Student · PJM Informatika',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jadwal hari ini',
                                style: TextStyle(color: _muted, fontSize: 13),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Minggu, 25 Okt',
                                style: TextStyle(
                                  color: _ink,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.calendar_month_outlined, color: _purple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MyAcademic',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Akses informasi dan kelola data akademikmu.',
                  style: TextStyle(color: _muted, fontSize: 13),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menu.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 18,
                    childAspectRatio: .72,
                  ),
                  itemBuilder: (context, index) {
                    final item = menu[index];
                    return InkWell(
                      onTap: () => onMenuTap(item.$2),
                      borderRadius: BorderRadius.circular(14),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: item.$3,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(item.$1, color: _purple, size: 28),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            item.$2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 11,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ClassroomPage extends StatelessWidget {
  const ClassroomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Room'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Kelas saya',
            style: TextStyle(
              color: _ink,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Pilih kelas untuk melihat materi, sesi, dan kuis.',
            style: TextStyle(color: _muted),
          ),
          const SizedBox(height: 20),
          _ClassCard(
            title: 'Bahasa Jepang',
            code: 'JP-N3-01',
            lecturer: '佐藤先生',
            subtitle: '日本語能力試験 N3',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ClassroomDetailPage()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassCard extends StatelessWidget {
  const _ClassCard({
    required this.title,
    required this.code,
    required this.lecturer,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String code;
  final String lecturer;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: _purple.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.language, color: _purple, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _ink,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$code · $lecturer',
                      style: const TextStyle(color: _muted, fontSize: 12),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(color: _purple, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: _muted),
            ],
          ),
        ),
      ),
    );
  }
}

class ClassroomDetailPage extends StatelessWidget {
  const ClassroomDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bahasa Jepang'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '日本語能力試験 N3',
            style: TextStyle(
              color: _ink,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text('文法・語彙・漢字を練習しましょう。', style: TextStyle(color: _muted)),
          const SizedBox(height: 20),
          _MaterialItem(
            title: '第1週：文法の復習',
            icon: Icons.menu_book_outlined,
            content: _grammarContent,
          ),
          _MaterialItem(
            title: '第2週：語彙と漢字',
            icon: Icons.translate,
            content: _vocabularyContent,
          ),
          _MaterialItem(
            title: '第3週：読解練習',
            icon: Icons.chrome_reader_mode_outlined,
            content: _readingContent,
          ),
          const SizedBox(height: 14),
          Card(
            color: _purple.withValues(alpha: .1),
            elevation: 0,
            child: ListTile(
              leading: const Icon(Icons.quiz_outlined, color: _purple),
              title: const Text(
                'JLPT CAT Quiz',
                style: TextStyle(color: _ink, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Latihan N5, N4, dan N3 dalam halaman penuh',
              ),
              trailing: const Icon(Icons.arrow_forward, color: _purple),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const QuizPage())),
            ),
          ),
        ],
      ),
    );
  }
}

const _grammarContent = [
  '〜のに：予想と違う結果を表します。',
  '例：毎日練習したのに、まだ上手になれません。',
  '〜ために：目的や理由を表します。',
  '例：健康のために、毎朝ジョギングをします。',
];

const _vocabularyContent = [
  '必要（ひつよう）：diperlukan',
  '最近（さいきん）：akhir-akhir ini',
  '注意（ちゅうい）：perhatian / hati-hati',
  '相談（そうだん）：konsultasi',
];

const _readingContent = [
  '文章を読むときは、まず全体の内容を確認しましょう。',
  '接続詞に注目すると、文と文の関係が分かりやすくなります。',
  '分からない言葉があっても、前後の文から意味を推測します。',
];

class _MaterialItem extends StatelessWidget {
  const _MaterialItem({
    required this.title,
    required this.icon,
    required this.content,
  });

  final String title;
  final IconData icon;
  final List<String> content;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.white,
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LessonDetailPage(title: title, content: content),
          ),
        ),
        leading: Icon(icon, color: _purple),
        title: Text(
          title,
          style: const TextStyle(color: _ink, fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.chevron_right, color: _muted),
      ),
    );
  }
}

class LessonDetailPage extends StatelessWidget {
  const LessonDetailPage({
    required this.title,
    required this.content,
    super.key,
  });

  final String title;
  final List<String> content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          ...content.map(
            (item) => Card(
              elevation: 0,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  item,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizQuestion {
  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.explanation,
  });

  final String question;
  final List<String> options;
  final int answer;
  final String explanation;
}

const _quizQuestionsN3 = [
  _QuizQuestion(
    question: '毎日練習した（　　　）、まだ上手になれない。',
    options: ['のに', 'ために', 'ように', 'ので'],
    answer: 0,
    explanation: '「のに」は、予想と違う結果を表します。',
  ),
  _QuizQuestion(
    question: '健康の（　　　）、毎朝ジョギングをしています。',
    options: ['わけで', 'ために', 'ところで', 'うちに'],
    answer: 1,
    explanation: '「〜のために」は目的や理由を表します。',
  ),
  _QuizQuestion(
    question: '先生に相談した（　　　）を忘れてしまった。',
    options: ['こと', 'もの', 'はず', 'わけ'],
    answer: 0,
    explanation: '「〜たことを忘れる」は、した経験や事実を表します。',
  ),
  _QuizQuestion(
    question: '「冷たい水」の読み方はどれですか。',
    options: ['つめたいみず', 'さむいみず', 'あついみず', 'からいみず'],
    answer: 0,
    explanation: '「冷たい」は「つめたい」と読みます。',
  ),
  _QuizQuestion(
    question: 'この道は車が多いので、子供（　　　）注意してください。',
    options: ['を', 'が', 'に', 'へ'],
    answer: 2,
    explanation: '「人に注意する」で、注意する相手を表します。',
  ),
];

const _quizQuestionsN5 = [
  _QuizQuestion(
    question: 'これは（　　　）ですか。',
    options: ['何', '誰', 'どこ', 'いつ'],
    answer: 0,
    explanation: '「何（なに）」 digunakan untuk menanyakan benda.',
  ),
  _QuizQuestion(
    question: 'わたしは毎朝、パン（　　　）食べます。',
    options: ['を', 'が', 'に', 'で'],
    answer: 0,
    explanation: 'Partikel を menandai objek yang dimakan.',
  ),
  _QuizQuestion(
    question: 'きのうは学校へ（　　　）。',
    options: ['行きます', '行きました', '行きません', '行く'],
    answer: 1,
    explanation: 'きのう menunjukkan masa lampau, jadi 行きました.',
  ),
];

const _quizQuestionsN4 = [
  _QuizQuestion(
    question: '雨が降っている（　　　）、出かけます。',
    options: ['のに', 'ので', 'でも', 'しか'],
    answer: 2,
    explanation: 'でも berarti “meskipun begitu”, menunjukkan kontras.',
  ),
  _QuizQuestion(
    question: '日本語が話せる（　　　）になりました。',
    options: ['こと', 'よう', 'ため', 'そう'],
    answer: 1,
    explanation: '〜ようになる menunjukkan perubahan kemampuan/kondisi.',
  ),
  _QuizQuestion(
    question: '駅に着いたら、電話して（　　　）ください。',
    options: ['みて', 'おいて', 'いて', 'しまって'],
    answer: 0,
    explanation: '〜てみてください berarti “silakan coba lakukan”.',
  ),
];

const _quizSets = {
  'N5': _quizQuestionsN5,
  'N4': _quizQuestionsN4,
  'N3': _quizQuestionsN3,
};

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final Map<int, int> _answers = {};
  int _currentQuestion = 0;
  bool _finished = false;
  String _level = 'N5';

  List<_QuizQuestion> get _questions => _quizSets[_level]!;

  void _finishQuiz() {
    if (_answers.length < _questions.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_questions.length - _answers.length} soal belum dijawab.',
          ),
        ),
      );
      return;
    }
    setState(() => _finished = true);
  }

  @override
  Widget build(BuildContext context) {
    final content = _finished
        ? _QuizResult(
            level: _level,
            questions: _questions,
            answers: _answers,
            score: _score,
          )
        : ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            children: [
              const Text(
                'JLPT CAT ミニクイズ',
                style: TextStyle(
                  color: _ink,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Pilih level lalu jawab satu soal per halaman',
                style: TextStyle(color: _muted),
              ),
              const SizedBox(height: 16),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'N5', label: Text('N5')),
                  ButtonSegment(value: 'N4', label: Text('N4')),
                  ButtonSegment(value: 'N3', label: Text('N3')),
                ],
                selected: {_level},
                onSelectionChanged: (selected) => setState(() {
                  _level = selected.first;
                  _answers.clear();
                  _currentQuestion = 0;
                }),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: (_currentQuestion + 1) / _questions.length,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                color: _purple,
              ),
              const SizedBox(height: 10),
              Text(
                '$_level · Soal ${_currentQuestion + 1} dari ${_questions.length}',
                style: const TextStyle(color: _muted),
              ),
              const SizedBox(height: 16),
              _QuestionCard(
                number: _currentQuestion + 1,
                question: _questions[_currentQuestion],
                selected: _answers[_currentQuestion],
                onSelected: (value) =>
                    setState(() => _answers[_currentQuestion] = value),
              ),
              Row(
                children: [
                  if (_currentQuestion > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentQuestion--),
                        child: const Text('Sebelumnya'),
                      ),
                    ),
                  if (_currentQuestion > 0) const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _answers[_currentQuestion] == null
                          ? null
                          : () {
                              if (_currentQuestion == _questions.length - 1) {
                                _finishQuiz();
                              } else {
                                setState(() => _currentQuestion++);
                              }
                            },
                      child: Text(
                        _currentQuestion == _questions.length - 1
                            ? 'Selesai'
                            : 'Berikutnya',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _questions
                    .asMap()
                    .entries
                    .map(
                      (entry) => ChoiceChip(
                        label: Text('${entry.key + 1}'),
                        selected: _currentQuestion == entry.key,
                        onSelected: (_) =>
                            setState(() => _currentQuestion = entry.key),
                        selectedColor: _purple.withValues(alpha: .2),
                      ),
                    )
                    .toList(),
              ),
            ],
          );

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('JLPT CAT Quiz'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(child: content),
    );
  }

  int get _score => _questions
      .asMap()
      .entries
      .where((entry) => _answers[entry.key] == entry.value.answer)
      .length;
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.number,
    required this.question,
    required this.selected,
    required this.onSelected,
  });

  final int number;
  final _QuizQuestion question;
  final int? selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number. ${question.question}',
              style: const TextStyle(
                color: _ink,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...question.options.asMap().entries.map(
              (option) => RadioListTile<int>(
                value: option.key,
                groupValue: selected,
                onChanged: (value) => onSelected(value!),
                title: Text(option.value),
                contentPadding: EdgeInsets.zero,
                dense: true,
                activeColor: _purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizResult extends StatelessWidget {
  const _QuizResult({
    required this.level,
    required this.questions,
    required this.answers,
    required this.score,
  });

  final String level;
  final List<_QuizQuestion> questions;
  final Map<int, int> answers;
  final int score;

  @override
  Widget build(BuildContext context) {
    final percentage = ((score / questions.length) * 100).round();
    final message = percentage >= 80
        ? 'すばらしいです！'
        : percentage >= 60
        ? 'よくできました！'
        : 'もう一度、教材を復習しましょう。';

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 30),
        const Icon(Icons.emoji_events_outlined, color: _purple, size: 72),
        const SizedBox(height: 14),
        Center(
          child: Text(
            'Quiz $level selesai!',
            style: TextStyle(
              color: _ink,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 22),
        Card(
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                const Text(
                  'SKOR AKHIR',
                  style: TextStyle(color: _muted, letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                Text(
                  '$percentage',
                  style: const TextStyle(
                    color: _purple,
                    fontSize: 54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$score dari ${questions.length} jawaban benar',
                  style: const TextStyle(color: _ink, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        Center(
          child: Text(
            message,
            style: const TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Evaluasi jawaban',
          style: TextStyle(
            color: _ink,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...questions.asMap().entries.map((entry) {
          final question = entry.value;
          final selected = answers[entry.key]!;
          final correct = selected == question.answer;
          return Card(
            elevation: 0,
            color: correct ? const Color(0xFFEAF7EE) : const Color(0xFFFFEEEE),
            margin: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.key + 1}. ${correct ? 'Benar' : 'Salah'}',
                    style: TextStyle(
                      color: correct
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    question.question,
                    style: const TextStyle(
                      color: _ink,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Jawaban kamu: ${question.options[selected]}',
                    style: const TextStyle(color: _ink),
                  ),
                  if (!correct)
                    Text(
                      'Jawaban benar: ${question.options[question.answer]}',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Text(
                    question.explanation,
                    style: const TextStyle(color: _muted),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _KanjiExample {
  const _KanjiExample({
    required this.character,
    required this.meaning,
    required this.reading,
    required this.strokes,
    required this.svgAsset,
  });

  final String character;
  final String meaning;
  final String reading;
  final List<String> strokes;
  final String svgAsset;
}

const _kanjiExamples = [
  _KanjiExample(
    character: '学',
    meaning: 'belajar',
    reading: 'がく・まなぶ',
    strokes: [
      'Tulis tiga titik kecil di bagian atas.',
      'Buat garis mendatar di bawah atap.',
      'Tulis 子: garis mendatar, kait, lalu dua garis bawah.',
    ],
    svgAsset: 'assets/kanjivg/05b66.svg',
  ),
  _KanjiExample(
    character: '校',
    meaning: 'sekolah',
    reading: 'こう',
    strokes: [
      'Tulis 木: garis mendatar lalu garis vertikal.',
      'Tambahkan dua garis miring pada 木.',
      'Di kanan, tulis 交: tutup dengan garis silang dan dua kaki.',
    ],
    svgAsset: 'assets/kanjivg/06821.svg',
  ),
  _KanjiExample(
    character: '生',
    meaning: 'hidup / lahir',
    reading: 'せい・しょう・いきる',
    strokes: [
      'Mulai dengan garis miring pendek di bagian atas.',
      'Tulis garis mendatar kedua dan garis vertikal.',
      'Tambahkan garis mendatar panjang di tengah.',
      'Tutup dengan garis mendatar di bagian bawah.',
    ],
    svgAsset: 'assets/kanjivg/0751f.svg',
  ),
  _KanjiExample(
    character: '先',
    meaning: 'dulu / depan',
    reading: 'せん・さき',
    strokes: [
      'Tulis garis miring pendek di atas.',
      'Buat garis mendatar dan garis vertikal.',
      'Tulis 儿 di bawah: dua kaki dengan kaki kiri lebih dahulu.',
    ],
    svgAsset: 'assets/kanjivg/05148.svg',
  ),
  _KanjiExample(
    character: '会',
    meaning: 'bertemu',
    reading: 'かい・あう',
    strokes: [
      'Tulis dua garis miring membentuk 人.',
      'Tambahkan garis mendatar sebagai atap.',
      'Tulis bagian bawah 𠆢 dengan garis pendek dan penutup.',
    ],
    svgAsset: 'assets/kanjivg/04f1a.svg',
  ),
];

class _FlutterPathProxy implements PathProxy {
  final path = Path();

  @override
  void close() => path.close();

  @override
  void cubicTo(
    double x1,
    double y1,
    double x2,
    double y2,
    double x3,
    double y3,
  ) {
    path.cubicTo(x1, y1, x2, y2, x3, y3);
  }

  @override
  void lineTo(double x, double y) => path.lineTo(x, y);

  @override
  void moveTo(double x, double y) => path.moveTo(x, y);
}

Future<List<Path>> _loadKanjiSvgPaths(String asset) async {
  final svg = await rootBundle.loadString(asset);
  final paths = <Path>[];
  final pathMatches = RegExp(r'<path\b[^>]*\bd="([^"]+)"').allMatches(svg);
  for (final match in pathMatches) {
    final proxy = _FlutterPathProxy();
    writeSvgPathDataToPath(match.group(1), proxy);
    paths.add(proxy.path);
  }
  if (paths.isEmpty) {
    throw FormatException('KanjiVG asset tidak memiliki stroke: $asset');
  }
  return paths;
}

class KanjiLearningPage extends StatefulWidget {
  const KanjiLearningPage({super.key});

  @override
  State<KanjiLearningPage> createState() => _KanjiLearningPageState();
}

class _KanjiLearningPageState extends State<KanjiLearningPage> {
  int _selectedKanji = 0;
  final Set<int> _completedPractice = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Kanji'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: _KanjiStudyView(
        selectedKanji: _selectedKanji,
        completedPractice: _completedPractice,
        onSelect: (index) => setState(() => _selectedKanji = index),
        onStartPractice: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => KanjiPracticePage(
                initialKanji: _selectedKanji,
                completedPractice: _completedPractice,
              ),
            ),
          );
          if (!mounted) return;
          setState(() {});
        },
      ),
    );
  }
}

class _KanjiStudyView extends StatelessWidget {
  const _KanjiStudyView({
    required this.selectedKanji,
    required this.completedPractice,
    required this.onSelect,
    required this.onStartPractice,
  });

  final int selectedKanji;
  final Set<int> completedPractice;
  final ValueChanged<int> onSelect;
  final VoidCallback onStartPractice;

  @override
  Widget build(BuildContext context) {
    final kanji = _kanjiExamples[selectedKanji];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: [
        const Text(
          'Lima kanji dasar',
          style: TextStyle(
            color: _ink,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Ikuti urutan goresan dari nomor pertama sampai terakhir.',
          style: TextStyle(color: _muted),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _kanjiExamples
              .asMap()
              .entries
              .map(
                (entry) => ChoiceChip(
                  label: Text(
                    entry.value.character,
                    style: const TextStyle(fontSize: 27),
                  ),
                  selected: selectedKanji == entry.key,
                  onSelected: (_) => onSelect(entry.key),
                  selectedColor: _purple.withValues(alpha: .2),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Text(
                  kanji.character,
                  style: const TextStyle(
                    color: _purple,
                    fontSize: 90,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  kanji.meaning,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  kanji.reading,
                  style: const TextStyle(color: _muted, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Cara menulis · ${kanji.strokes.length} langkah',
          style: const TextStyle(
            color: _ink,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ...kanji.strokes.asMap().entries.map(
          (entry) => Card(
            elevation: 0,
            margin: const EdgeInsets.only(bottom: 10),
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _purple.withValues(alpha: .12),
                child: Text(
                  '${entry.key + 1}',
                  style: const TextStyle(
                    color: _purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                entry.value,
                style: const TextStyle(color: _ink, height: 1.35),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: onStartPractice,
          icon: const Icon(Icons.draw_outlined),
          label: Text(
            completedPractice.contains(selectedKanji)
                ? 'Ulangi latihan menulis'
                : 'Mulai latihan menulis',
          ),
        ),
      ],
    );
  }
}

class KanjiPracticePage extends StatefulWidget {
  const KanjiPracticePage({
    required this.initialKanji,
    required this.completedPractice,
    super.key,
  });

  final int initialKanji;
  final Set<int> completedPractice;

  @override
  State<KanjiPracticePage> createState() => _KanjiPracticePageState();
}

class _KanjiPracticePageState extends State<KanjiPracticePage> {
  late int _selectedKanji;
  final Map<int, List<Path>> _kanjiPaths = {};
  final Map<int, List<List<Offset>>> _completedStrokes = {};
  final Map<int, List<Offset>> _activeStrokes = {};
  double _drawingSize = 300;
  String _feedback = 'Ikuti titik biru dan arah panah untuk goresan pertama.';

  @override
  void initState() {
    super.initState();
    _selectedKanji = widget.initialKanji;
    _loadPaths(_selectedKanji);
  }

  Future<void> _loadPaths(int index) async {
    try {
      final paths = await _loadKanjiSvgPaths(_kanjiExamples[index].svgAsset);
      if (!mounted) return;
      setState(() => _kanjiPaths[index] = paths);
    } catch (error) {
      if (!mounted) return;
      setState(() => _feedback = 'Data KanjiVG gagal dimuat: $error');
    }
  }

  List<Offset> get _points => _activeStrokes[_selectedKanji] ?? [];
  List<List<Offset>> get _completed => _completedStrokes[_selectedKanji] ?? [];
  List<Path> get _paths => _kanjiPaths[_selectedKanji] ?? [];

  void _updatePoints(List<Offset> points) {
    setState(() => _activeStrokes[_selectedKanji] = points);
  }

  void _finishStroke() {
    if (_points.length < 2) return;
    final kanji = _kanjiExamples[_selectedKanji];
    final strokeIndex = _completed.length;
    if (strokeIndex >= _paths.length) return;

    if (_isStrokeCorrect(_points, _paths[strokeIndex])) {
      final completed = [..._completed, _points];
      setState(() {
        _completedStrokes[_selectedKanji] = completed;
        _activeStrokes[_selectedKanji] = [];
        if (completed.length == _paths.length) {
          widget.completedPractice.add(_selectedKanji);
          _feedback = 'Semua goresan benar! Kanji ${kanji.character} selesai.';
        } else {
          _feedback =
              'Benar! Goresan ${completed.length} tetap sebagai patokan. Lanjut ke titik biru berikutnya.';
        }
      });
    } else {
      setState(() {
        _activeStrokes[_selectedKanji] = [];
        _feedback = 'Belum tepat. Mulai dari titik biru dan ikuti arah panah.';
      });
    }
  }

  bool _isStrokeCorrect(List<Offset> points, Path guide) {
    final size = _drawingSize;
    final metric = guide.computeMetrics().first;
    final start = metric.getTangentForOffset(0)!.position / 109 * size;
    final end =
        metric.getTangentForOffset(metric.length)!.position / 109 * size;
    final userStart = points.first;
    final userEnd = points.last;
    final startDistance = (userStart - start).distance;
    final endDistance = (userEnd - end).distance;
    final userVector = userEnd - userStart;
    final guideVector = end - start;
    final denominator = userVector.distance * guideVector.distance;
    final cosine = denominator == 0
        ? 0
        : (userVector.dx * guideVector.dx + userVector.dy * guideVector.dy) /
              denominator;
    return startDistance < size * .20 &&
        endDistance < size * .20 &&
        cosine > .25 &&
        userVector.distance > size * .08;
  }

  void _completePractice() {
    if (_paths.isEmpty || _completed.length != _paths.length) {
      return;
    }
    widget.completedPractice.add(_selectedKanji);
    setState(
      () => _feedback = 'Latihan selesai. Semua patokan goresan sudah benar.',
    );
  }

  void _undoStroke() {
    if (_completed.isEmpty) return;
    final completed = [..._completed]..removeLast();
    setState(() {
      _completedStrokes[_selectedKanji] = completed;
      _feedback = 'Goresan terakhir dibatalkan. Ikuti patokan yang tersisa.';
    });
  }

  @override
  Widget build(BuildContext context) {
    final kanji = _kanjiExamples[_selectedKanji];
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Latihan Menulis Kanji'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Panduan menulis'),
                content: const Text(
                  'Ikuti contoh samar dengan jari. Biasakan menulis dari atas ke bawah dan dari kiri ke kanan.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Mengerti'),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.help_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Row(
                children: [
                  Text(
                    kanji.character,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kanji.meaning,
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          kanji.reading,
                          style: const TextStyle(color: _muted),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${kanji.strokes.length} goresan',
                    style: const TextStyle(
                      color: _purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _kanjiExamples
                    .asMap()
                    .entries
                    .map(
                      (entry) => ChoiceChip(
                        label: Text(
                          entry.value.character,
                          style: const TextStyle(fontSize: 21),
                        ),
                        selected: _selectedKanji == entry.key,
                        onSelected: (_) => setState(() {
                          _selectedKanji = entry.key;
                          _loadPaths(entry.key);
                          _feedback =
                              'Ikuti titik biru dan arah panah untuk goresan pertama.';
                        }),
                        selectedColor: _purple.withValues(alpha: .2),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 10),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final size = constraints.biggest.shortestSide;
                    _drawingSize = size;
                    return Center(
                      child: SizedBox(
                        width: size,
                        height: size,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: _purple.withValues(alpha: .25),
                            ),
                          ),
                          child: GestureDetector(
                            onPanStart: (details) =>
                                _updatePoints([details.localPosition]),
                            onPanUpdate: (details) => _updatePoints([
                              ..._points,
                              details.localPosition,
                            ]),
                            onPanEnd: (_) => _finishStroke(),
                            child: CustomPaint(
                              painter: _KanjiPracticePainter(
                                character: kanji.character,
                                points: _points,
                                guidePaths: _paths,
                                completedStrokes: _completed,
                                activeStrokeIndex: _completed.length,
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                _feedback,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _muted),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                spacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(
                      () => _feedback =
                          'Titik biru adalah awal. Ikuti garis ungu menuju ujung panah.',
                    ),
                    icon: const Icon(Icons.lightbulb_outline),
                    label: const Text('Petunjuk'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _points.isEmpty ? null : _undoStroke,
                    icon: const Icon(Icons.undo),
                    label: const Text('Batalkan'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _activeStrokes[_selectedKanji] = [];
                      _completedStrokes[_selectedKanji] = [];
                      _feedback =
                          'Canvas di-reset. Ikuti titik biru untuk memulai lagi.';
                    }),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset'),
                  ),
                  FilledButton.icon(
                    onPressed: _points.isEmpty ? null : _completePractice,
                    icon: const Icon(Icons.check),
                    label: const Text('Selesai'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KanjiPracticeView extends StatefulWidget {
  const _KanjiPracticeView({
    required this.selectedKanji,
    required this.completedPractice,
    required this.onSelect,
    required this.onComplete,
  });

  final int selectedKanji;
  final Set<int> completedPractice;
  final ValueChanged<int> onSelect;
  final VoidCallback onComplete;

  @override
  State<_KanjiPracticeView> createState() => _KanjiPracticeViewState();
}

class _KanjiPracticeViewState extends State<_KanjiPracticeView> {
  List<Offset> _points = [];

  @override
  void didUpdateWidget(covariant _KanjiPracticeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedKanji != widget.selectedKanji) {
      _points = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final kanji = _kanjiExamples[widget.selectedKanji];
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      children: [
        const Text(
          'Latihan menulis kanji',
          style: TextStyle(
            color: _ink,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Ikuti contoh samar di tengah, lalu tulis kanji dengan jari.',
          style: TextStyle(color: _muted),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          children: _kanjiExamples
              .asMap()
              .entries
              .map(
                (entry) => ChoiceChip(
                  label: Text(
                    entry.value.character,
                    style: const TextStyle(fontSize: 22),
                  ),
                  selected: widget.selectedKanji == entry.key,
                  onSelected: (_) => widget.onSelect(entry.key),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _purple.withValues(alpha: .25)),
          ),
          child: GestureDetector(
            onPanStart: (details) =>
                setState(() => _points = [details.localPosition]),
            onPanUpdate: (details) =>
                setState(() => _points = [..._points, details.localPosition]),
            onPanEnd: (_) =>
                setState(() => _points = [..._points, Offset.infinite]),
            child: CustomPaint(
              painter: _KanjiPracticePainter(
                character: kanji.character,
                points: _points,
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => setState(() => _points = []),
              icon: const Icon(Icons.refresh),
              label: const Text('Hapus'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: _points.isEmpty
                  ? null
                  : () {
                      widget.onComplete();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Latihan kanji selesai ditandai.'),
                        ),
                      );
                    },
              icon: const Icon(Icons.check),
              label: const Text('Selesai latihan'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Card(
          elevation: 0,
          color: _purple.withValues(alpha: .08),
          child: ListTile(
            leading: const Icon(Icons.flag_outlined, color: _purple),
            title: Text(
              widget.completedPractice.contains(widget.selectedKanji)
                  ? 'Latihan selesai'
                  : 'Belum selesai',
            ),
            subtitle: Text(
              'Target: tulis 「${kanji.character}」 mengikuti ${kanji.strokes.length} langkah.',
            ),
          ),
        ),
      ],
    );
  }
}

class _KanjiPracticePainter extends CustomPainter {
  const _KanjiPracticePainter({
    required this.character,
    required this.points,
    this.guidePaths = const [],
    this.completedStrokes = const [],
    this.activeStrokeIndex = 0,
  });

  final String character;
  final List<Offset> points;
  final List<Path> guidePaths;
  final List<List<Offset>> completedStrokes;
  final int activeStrokeIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFFE4E1F4)
      ..strokeWidth = 1;
    final gridDash = Paint()
      ..color = const Color(0xFFECEAF7)
      ..strokeWidth = 1;
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    canvas.drawLine(
      Offset(halfWidth, 0),
      Offset(halfWidth, size.height),
      gridDash,
    );
    canvas.drawLine(
      Offset(0, halfHeight),
      Offset(size.width, halfHeight),
      gridDash,
    );
    canvas.drawLine(Offset.zero, Offset(size.width, size.height), gridDash);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), gridDash);
    canvas.drawRect(Offset.zero & size, gridPaint);

    Offset scaleKanjiPoint(Offset point) =>
        Offset(point.dx / 109 * size.width, point.dy / 109 * size.height);

    final remainingGuidePaint = Paint()
      ..color = _purple.withValues(alpha: .10)
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final activeGuidePaint = Paint()
      ..color = _purple.withValues(alpha: .35)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    if (guidePaths.isNotEmpty) {
      for (var index = activeStrokeIndex; index < guidePaths.length; index++) {
        canvas.save();
        canvas.scale(size.width / 109, size.height / 109);
        canvas.drawPath(
          guidePaths[index],
          index == activeStrokeIndex
              ? (activeGuidePaint..strokeWidth = 8)
              : remainingGuidePaint,
        );
        canvas.restore();
        final metric = guidePaths[index].computeMetrics().first;
        final start = scaleKanjiPoint(metric.getTangentForOffset(0)!.position);
        final end = scaleKanjiPoint(
          metric.getTangentForOffset(metric.length)!.position,
        );
        if (index == activeStrokeIndex) {
          canvas.drawCircle(start, 9, Paint()..color = const Color(0xFF2563EB));
          final direction = end - start;
          final length = direction.distance;
          if (length > 0) {
            final unit = direction / length;
            final side = Offset(-unit.dy, unit.dx);
            final arrowPaint = Paint()
              ..color = _purple
              ..strokeWidth = 3
              ..style = PaintingStyle.stroke;
            final arrow = Path()
              ..moveTo(end.dx, end.dy)
              ..lineTo(
                end.dx - unit.dx * 16 + side.dx * 8,
                end.dy - unit.dy * 16 + side.dy * 8,
              )
              ..moveTo(end.dx, end.dy)
              ..lineTo(
                end.dx - unit.dx * 16 - side.dx * 8,
                end.dy - unit.dy * 16 - side.dy * 8,
              );
            canvas.drawPath(arrow, arrowPaint);
          }
        }
      }
    }

    for (final stroke in completedStrokes) {
      final completedPaint = Paint()
        ..color = const Color(0xFF238636)
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      if (stroke.length > 1) {
        final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
        for (final point in stroke.skip(1)) {
          path.lineTo(point.dx, point.dy);
        }
        canvas.drawPath(path, completedPaint);
      }
    }

    final paint = Paint()
      ..color = const Color(0xFF2563EB)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    if (points.length > 1) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _KanjiPracticePainter oldDelegate) =>
      oldDelegate.points != points ||
      oldDelegate.character != character ||
      oldDelegate.guidePaths != guidePaths ||
      oldDelegate.completedStrokes != completedStrokes ||
      oldDelegate.activeStrokeIndex != activeStrokeIndex;
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jelajah'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF008F91), Color(0xFF006A72)],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kelas pilihan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Belajar dari para ahli dan kembangkan kemampuanmu.',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const _ExploreSectionTitle(title: 'Kelas populer'),
          SizedBox(
            height: 285,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: const [
                _ExploreCard(
                  title: 'Bahasa Jepang N3',
                  category: 'Bahasa',
                  icon: Icons.language,
                  color: Color(0xFFE8DFFF),
                ),
                _ExploreCard(
                  title: 'Persiapan Karier',
                  category: 'Pengembangan diri',
                  icon: Icons.work_outline,
                  color: Color(0xFFFFE7C2),
                ),
              ],
            ),
          ),
          const _ExploreSectionTitle(title: 'Kursus online terbuka'),
          const _OpenCourseCard(
            title: 'Kewirausahaan',
            category: 'Agribisnis',
            icon: Icons.storefront_outlined,
            color: Color(0xFFE5D6FF),
          ),
          const _OpenCourseCard(
            title: 'Metode Numerik',
            category: 'Matematika',
            icon: Icons.calculate_outlined,
            color: Color(0xFFD6ECFF),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ExploreSectionTitle extends StatelessWidget {
  const _ExploreSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Text(
        title,
        style: const TextStyle(
          color: _ink,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  const _ExploreCard({
    required this.title,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String title;
  final String category;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 125,
            color: color,
            child: Center(child: Icon(icon, color: _purple, size: 62)),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(category, style: const TextStyle(color: _muted)),
                const SizedBox(height: 16),
                const Text(
                  'GRATIS',
                  style: TextStyle(color: _purple, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OpenCourseCard extends StatelessWidget {
  const _OpenCourseCard({
    required this.title,
    required this.category,
    required this.icon,
    required this.color,
  });

  final String title;
  final String category;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: _purple, size: 34),
        ),
        title: Text(
          title,
          style: const TextStyle(color: _ink, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(category),
        ),
        trailing: const Icon(Icons.arrow_forward, color: _purple),
        onTap: () {},
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  radius: 29,
                  backgroundColor: _purple.withValues(alpha: .15),
                  child: const Text(
                    'AM',
                    style: TextStyle(
                      color: _purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: const Text(
                  'Abdul Majid',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: const Text(
                  'Belum ada pesan baru',
                  style: TextStyle(color: _muted),
                ),
                onTap: () {},
              ),
              const Divider(height: 1),
            ],
          ),
          Positioned(
            right: 24,
            bottom: 24,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFFFFB21A),
              foregroundColor: _ink,
              child: const Icon(Icons.forum_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.person_outline,
        'Kelola Profil',
        'Perbarui data diri dan foto profil',
      ),
      (
        Icons.folder_copy_outlined,
        'Media Library',
        'Lihat file dan materi tersimpan',
      ),
      (Icons.school_outlined, 'Kelola Akun', 'Kelola akun akademikmu'),
      (
        Icons.article_outlined,
        'Panduan Pengguna',
        'Pelajari cara menggunakan LMS',
      ),
      (Icons.settings_outlined, 'Pengaturan', 'Atur notifikasi dan preferensi'),
      (Icons.help_outline, 'FAQ', 'Pertanyaan yang sering ditanyakan'),
      (Icons.logout, 'Keluar', 'Keluar dari akun LMS'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lainnya'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const ListTile(
            contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 14),
            leading: CircleAvatar(
              radius: 29,
              backgroundColor: _purple,
              child: Text(
                'LM',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              'lulu malik',
              style: TextStyle(
                color: _ink,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Mahasiswa · PJJ Informatika'),
          ),
          const Divider(height: 1),
          ...items.map(
            (item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8,
              ),
              leading: Icon(item.$1, color: _ink, size: 27),
              title: Text(
                item.$2,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                item.$3,
                style: const TextStyle(color: _muted, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right, color: _muted),
              onTap: item.$2 == 'Keluar'
                  ? () => _logoutToLogin(context)
                  : () {},
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text('Versi 1.0.0', style: TextStyle(color: _muted)),
          ),
        ],
      ),
    );
  }
}

class _StudentData {
  const _StudentData._();

  static const String name = 'lulu malik';
  static const String initials = 'LM';
  static const String nim = '221011400123';
  static const String program = 'PJJ Informatika';
  static const String studyProgram = 'Informatika';
  static const String status = 'Aktif';
}

String _formatClock(DateTime time) {
  String two(int value) => value.toString().padLeft(2, '0');
  return '${two(time.hour)}:${two(time.minute)}:${two(time.second)}';
}

class _AttendanceRecord {
  const _AttendanceRecord({
    required this.course,
    required this.date,
    required this.time,
    required this.status,
  });

  final String course;
  final String date;
  final String time;
  final String status;
}

const _attendanceHistory = [
  _AttendanceRecord(
    course: 'Bahasa Jepang',
    date: '25 Okt 2026',
    time: '08:04',
    status: 'Hadir',
  ),
  _AttendanceRecord(
    course: 'Metode Numerik',
    date: '24 Okt 2026',
    time: '10:12',
    status: 'Terlambat',
  ),
  _AttendanceRecord(
    course: 'Kewirausahaan',
    date: '23 Okt 2026',
    time: '13:01',
    status: 'Hadir',
  ),
  _AttendanceRecord(
    course: 'Metode Numerik',
    date: '17 Okt 2026',
    time: '10:22',
    status: 'Alfa',
  ),
];

class PresensiQrPage extends StatefulWidget {
  const PresensiQrPage({super.key});

  @override
  State<PresensiQrPage> createState() => _PresensiQrPageState();
}

class _PresensiQrPageState extends State<PresensiQrPage> {
  static const Duration _validity = Duration(seconds: 60);

  Timer? _timer;
  late String _payload;
  late DateTime _issuedAt;

  @override
  void initState() {
    super.initState();
    _generate();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsLeft <= 0) {
        _regenerate();
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int get _secondsLeft {
    final remaining = _validity - DateTime.now().difference(_issuedAt);
    return remaining.isNegative ? 0 : remaining.inSeconds;
  }

  void _generate() {
    final issuedAt = DateTime.now();
    _issuedAt = issuedAt;
    _payload =
        'LMS|PRESENSI|${_StudentData.nim}|${_StudentData.name}|'
        '${issuedAt.millisecondsSinceEpoch}';
  }

  void _regenerate() => setState(_generate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Presensi Kehadiran'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const Text(
            'Presensi QR',
            style: TextStyle(
              color: _ink,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tunjukkan kode ini pada dosen atau perangkat pemindai untuk mencatat kehadiranmu.',
            style: TextStyle(color: _muted),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE8E7F0)),
                    ),
                    child: QrImageView(
                      data: _payload,
                      size: 220,
                      padding: EdgeInsets.zero,
                      gapless: true,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: _ink,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: _ink,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    _StudentData.name,
                    style: const TextStyle(
                      color: _ink,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'NIM ${_StudentData.nim} · ${_StudentData.program}',
                    style: const TextStyle(color: _muted, fontSize: 13),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.schedule, size: 16, color: _muted),
                      const SizedBox(width: 6),
                      Text(
                        'Berlaku ${_secondsLeft}s · diperbarui ${_formatClock(_issuedAt)}',
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: _secondsLeft / _validity.inSeconds,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(6),
                    color: _purple,
                    backgroundColor: _purple.withValues(alpha: .12),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _regenerate,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Perbarui QR'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Ringkasan kehadiran',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: _AttendanceStat(
                  label: 'Hadir',
                  value: '12',
                  color: Color(0xFF2E9E5B),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _AttendanceStat(
                  label: 'Terlambat',
                  value: '2',
                  color: Color(0xFFE0A100),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _AttendanceStat(
                  label: 'Alfa',
                  value: '1',
                  color: Color(0xFFD64545),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Riwayat kehadiran',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          ..._attendanceHistory.map(
            (record) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _purple.withValues(alpha: .12),
                  child: const Icon(
                    Icons.event_available_outlined,
                    color: _purple,
                    size: 22,
                  ),
                ),
                title: Text(
                  record.course,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('${record.date} · ${record.time}'),
                trailing: _StatusChip(status: record.status),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceStat extends StatelessWidget {
  const _AttendanceStat({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      'Hadir' => const Color(0xFF2E9E5B),
      'Terlambat' => const Color(0xFFE0A100),
      _ => const Color(0xFFD64545),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class KartuMahasiswaPage extends StatelessWidget {
  const KartuMahasiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Kartu Mahasiswa'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: const [
          _StudentIdCard(),
          SizedBox(height: 22),
          Text(
            'Data mahasiswa',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          _InfoTile(
            icon: Icons.person_outline,
            label: 'Nama lengkap',
            value: _StudentData.name,
          ),
          _InfoTile(
            icon: Icons.confirmation_number_outlined,
            label: 'NIM',
            value: _StudentData.nim,
          ),
          _InfoTile(
            icon: Icons.school_outlined,
            label: 'Program studi',
            value: _StudentData.studyProgram,
          ),
          _InfoTile(
            icon: Icons.laptop_mac_outlined,
            label: 'Program',
            value: _StudentData.program,
          ),
          _InfoTile(
            icon: Icons.verified_outlined,
            label: 'Status',
            value: _StudentData.status,
          ),
        ],
      ),
    );
  }
}

class _StudentIdCard extends StatelessWidget {
  const _StudentIdCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_purple, _violet],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _purple.withValues(alpha: .25),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.school, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LMS Student',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Kartu Mahasiswa',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .22),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  _StudentData.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: Text(
                  _StudentData.initials,
                  style: TextStyle(
                    color: _purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _StudentData.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _StudentData.program,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Text(
                  'NIM',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Spacer(),
                Text(
                  _StudentData.nim,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _purple.withValues(alpha: .12),
          child: Icon(icon, color: _purple, size: 22),
        ),
        title: Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: _ink,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(subtitle, style: const TextStyle(color: _muted)),
      ],
    );
  }
}

class _GradientSummaryCard extends StatelessWidget {
  const _GradientSummaryCard({required this.label, required this.value, this.footnote});

  final String label;
  final String value;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_purple, _violet],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _purple.withValues(alpha: .25),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (footnote != null) ...[
            const SizedBox(height: 12),
            Text(
              footnote!,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentItem {
  const _PaymentItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.status,
  });

  final String title;
  final String subtitle;
  final String amount;
  final String status;
}

const _paymentItems = [
  _PaymentItem(
    title: 'UKT Semester 5',
    subtitle: 'Jatuh tempo 30 Okt 2026',
    amount: 'Rp 2.400.000',
    status: 'Belum bayar',
  ),
  _PaymentItem(
    title: 'UKT Semester 4',
    subtitle: 'Dibayar 12 Mar 2026',
    amount: 'Rp 2.400.000',
    status: 'Lunas',
  ),
  _PaymentItem(
    title: 'Biaya Praktikum',
    subtitle: 'Dibayar 05 Mar 2026',
    amount: 'Rp 350.000',
    status: 'Lunas',
  ),
  _PaymentItem(
    title: 'Biaya Perpustakaan',
    subtitle: 'Menunggu konfirmasi bank',
    amount: 'Rp 100.000',
    status: 'Menunggu verifikasi',
  ),
];

Color _paymentStatusColor(String status) => switch (status) {
  'Lunas' => const Color(0xFF2E9E5B),
  'Menunggu verifikasi' => const Color(0xFFE0A100),
  _ => const Color(0xFFD64545),
};

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Pembayaran'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Ringkasan tagihan',
            subtitle: 'Pantau status pembayaran akademikmu di sini.',
          ),
          const SizedBox(height: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _GradientSummaryCard(
                label: 'Total tagihan aktif',
                value: 'Rp 2.400.000',
                footnote: 'Jatuh tempo 30 Okt 2026',
              ),
              const SizedBox(height: 14),
              FilledButton.icon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Instruksi pembayaran dikirim ke email.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                ),
                icon: const Icon(Icons.payments_outlined),
                label: const Text('Bayar sekarang'),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const Text(
            'Riwayat pembayaran',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ..._paymentItems.map(
            (item) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: _purple.withValues(alpha: .12),
                      child: const Icon(
                        Icons.receipt_long_outlined,
                        color: _purple,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.subtitle,
                            style: const TextStyle(color: _muted, fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          _TagPill(
                            label: item.status,
                            color: _paymentStatusColor(item.status),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item.amount,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Course {
  const _Course({
    required this.code,
    required this.name,
    required this.sks,
    required this.lecturer,
    required this.schedule,
    required this.color,
  });

  final String code;
  final String name;
  final int sks;
  final String lecturer;
  final String schedule;
  final Color color;
}

const _courses = [
  _Course(
    code: 'IF-501',
    name: 'Pemrograman Mobile',
    sks: 3,
    lecturer: 'Dr. Andi Pratama',
    schedule: 'Senin · 08.00–10.30',
    color: Color(0xFFE5E1FF),
  ),
  _Course(
    code: 'IF-502',
    name: 'Basis Data Lanjut',
    sks: 3,
    lecturer: 'Rina Kusuma, M.Kom.',
    schedule: 'Selasa · 13.00–15.30',
    color: Color(0xFFE0F5EA),
  ),
  _Course(
    code: 'IF-503',
    name: 'Jaringan Komputer',
    sks: 3,
    lecturer: 'Budi Santoso, M.T.',
    schedule: 'Rabu · 09.00–11.30',
    color: Color(0xFFD6ECFF),
  ),
  _Course(
    code: 'IF-504',
    name: 'Kecerdasan Buatan',
    sks: 3,
    lecturer: 'Dr. Sari Melati',
    schedule: 'Kamis · 10.00–12.30',
    color: Color(0xFFFFE7C2),
  ),
  _Course(
    code: 'IF-505',
    name: 'Metode Numerik',
    sks: 2,
    lecturer: 'Agus Wijaya, M.Si.',
    schedule: 'Jumat · 08.00–09.40',
    color: Color(0xFFE0F5F5),
  ),
  _Course(
    code: 'IF-506',
    name: 'Bahasa Jepang',
    sks: 2,
    lecturer: '佐藤先生',
    schedule: 'Jumat · 13.00–14.40',
    color: Color(0xFFFFE1EC),
  ),
];

class MataKuliahPage extends StatelessWidget {
  const MataKuliahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Mata Kuliah'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Semester 5',
            subtitle: 'Total 16 SKS · 6 mata kuliah aktif',
          ),
          const SizedBox(height: 18),
          ..._courses.map(
            (course) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: course.color,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.menu_book_outlined,
                            color: _purple,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: const TextStyle(
                                  color: _ink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${course.code} · ${course.sks} SKS',
                                style: const TextStyle(
                                  color: _muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 16,
                          color: _muted,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            course.lecturer,
                            style: const TextStyle(color: _ink, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: _muted),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            course.schedule,
                            style: const TextStyle(color: _ink, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamResult {
  const _ExamResult({
    required this.course,
    required this.type,
    required this.score,
    required this.grade,
    required this.date,
  });

  final String course;
  final String type;
  final int score;
  final String grade;
  final String date;
}

const _examResults = [
  _ExamResult(
    course: 'Metode Numerik',
    type: 'UAS',
    score: 88,
    grade: 'A',
    date: '24 Jun 2026',
  ),
  _ExamResult(
    course: 'Basis Data Lanjut',
    type: 'UTS',
    score: 80,
    grade: 'A-',
    date: '08 Apr 2026',
  ),
  _ExamResult(
    course: 'Bahasa Jepang',
    type: 'Kuis',
    score: 92,
    grade: 'A',
    date: '15 Mei 2026',
  ),
  _ExamResult(
    course: 'Jaringan Komputer',
    type: 'UAS',
    score: 76,
    grade: 'B+',
    date: '26 Jun 2026',
  ),
  _ExamResult(
    course: 'Kecerdasan Buatan',
    type: 'UTS',
    score: 70,
    grade: 'B',
    date: '09 Apr 2026',
  ),
];

Color _gradeColor(String grade) {
  if (grade.startsWith('A')) return const Color(0xFF2E9E5B);
  if (grade.startsWith('B')) return const Color(0xFFE0A100);
  return const Color(0xFFD64545);
}

class HasilUjianPage extends StatelessWidget {
  const HasilUjianPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Hasil Ujian'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Hasil ujian',
            subtitle: 'Rekap nilai ujian dan kuis tiap mata kuliah.',
          ),
          const SizedBox(height: 18),
          const _GradientSummaryCard(
            label: 'Indeks Prestasi Kumulatif',
            value: '3.72',
            footnote: 'Rata-rata nilai 81 · 84 SKS ditempuh',
          ),
          const SizedBox(height: 26),
          const Text(
            'Daftar nilai',
            style: TextStyle(
              color: _ink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ..._examResults.map(
            (result) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _purple.withValues(alpha: .12),
                      child: const Icon(
                        Icons.assignment_outlined,
                        color: _purple,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            result.course,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${result.type} · ${result.date}',
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${result.score}',
                          style: const TextStyle(
                            color: _ink,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        _TagPill(
                          label: result.grade,
                          color: _gradeColor(result.grade),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Assignment {
  const _Assignment({
    required this.title,
    required this.course,
    required this.deadline,
    required this.status,
  });

  final String title;
  final String course;
  final String deadline;
  final String status;
}

const _assignments = [
  _Assignment(
    title: 'Laporan Praktikum Minggu 6',
    course: 'Jaringan Komputer',
    deadline: '28 Okt 2026 · 23.59',
    status: 'Belum dikumpulkan',
  ),
  _Assignment(
    title: 'Implementasi REST API',
    course: 'Pemrograman Mobile',
    deadline: '27 Okt 2026 · 23.59',
    status: 'Terkumpul',
  ),
  _Assignment(
    title: 'Ringkasan Jurnal AI',
    course: 'Kecerdasan Buatan',
    deadline: '25 Okt 2026 · 23.59',
    status: 'Terkumpul',
  ),
  _Assignment(
    title: 'Latihan Soal Numerik',
    course: 'Metode Numerik',
    deadline: '22 Okt 2026 · 23.59',
    status: 'Terlambat',
  ),
];

Color _assignmentStatusColor(String status) => switch (status) {
  'Terkumpul' => const Color(0xFF2E9E5B),
  'Belum dikumpulkan' => const Color(0xFFE0A100),
  _ => const Color(0xFFD64545),
};

class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Tugas'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Daftar tugas',
            subtitle: 'Pantau tenggat dan status pengumpulan tugasmu.',
          ),
          const SizedBox(height: 18),
          ..._assignments.map(
            (task) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: _purple.withValues(alpha: .12),
                      child: const Icon(
                        Icons.edit_note,
                        color: _purple,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            task.course,
                            style: const TextStyle(
                              color: _purple,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 14,
                                color: _muted,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                task.deadline,
                                style: const TextStyle(
                                  color: _muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          _TagPill(
                            label: task.status,
                            color: _assignmentStatusColor(task.status),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Consultation {
  const _Consultation({
    required this.initials,
    required this.name,
    required this.topic,
    required this.availability,
  });

  final String initials;
  final String name;
  final String topic;
  final String availability;
}

const _consultations = [
  _Consultation(
    initials: 'AP',
    name: 'Dr. Andi Pratama',
    topic: 'Pemrograman Mobile',
    availability: 'Senin & Rabu · 15.00–17.00',
  ),
  _Consultation(
    initials: 'RK',
    name: 'Rina Kusuma, M.Kom.',
    topic: 'Basis Data Lanjut',
    availability: 'Selasa · 09.00–11.00',
  ),
  _Consultation(
    initials: 'SM',
    name: 'Dr. Sari Melati',
    topic: 'Kecerdasan Buatan',
    availability: 'Kamis · 13.00–15.00',
  ),
];

class KonsultasiPage extends StatelessWidget {
  const KonsultasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Konsultasi'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Konsultasi akademik',
            subtitle: 'Ajukan sesi konsultasi dengan dosen pengampu.',
          ),
          const SizedBox(height: 18),
          Card(
            elevation: 0,
            color: _purple.withValues(alpha: .1),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: _purple),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Sertakan topik dan lampiran pendukung agar dosen dapat menyiapkan jawaban.',
                      style: TextStyle(color: _ink, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          ..._consultations.map(
            (item) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: _purple.withValues(alpha: .15),
                          child: Text(
                            item.initials,
                            style: const TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: _ink,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item.topic,
                                style: const TextStyle(
                                  color: _purple,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.schedule, size: 16, color: _muted),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            item.availability,
                            style: const TextStyle(color: _muted, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Permintaan konsultasi ke ${item.name} terkirim.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            ),
                        icon: const Icon(Icons.send_outlined),
                        label: const Text('Ajukan konsultasi'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TranscriptCourse {
  const _TranscriptCourse({
    required this.code,
    required this.name,
    required this.sks,
    required this.grade,
  });

  final String code;
  final String name;
  final int sks;
  final String grade;
}

class _SemesterRecord {
  const _SemesterRecord({
    required this.label,
    required this.sks,
    required this.ip,
    required this.courses,
  });

  final String label;
  final int sks;
  final String ip;
  final List<_TranscriptCourse> courses;
}

const _transcript = [
  _SemesterRecord(
    label: 'Semester 4',
    sks: 20,
    ip: '3.85',
    courses: [
      _TranscriptCourse(
        code: 'IF-401',
        name: 'Algoritma dan Struktur Data',
        sks: 3,
        grade: 'A',
      ),
      _TranscriptCourse(
        code: 'IF-402',
        name: 'Pemrograman Web',
        sks: 3,
        grade: 'A',
      ),
      _TranscriptCourse(
        code: 'IF-403',
        name: 'Sistem Operasi',
        sks: 3,
        grade: 'A-',
      ),
      _TranscriptCourse(
        code: 'IF-404',
        name: 'Statistika',
        sks: 2,
        grade: 'B+',
      ),
    ],
  ),
  _SemesterRecord(
    label: 'Semester 3',
    sks: 22,
    ip: '3.61',
    courses: [
      _TranscriptCourse(
        code: 'IF-301',
        name: 'Struktur Diskrit',
        sks: 3,
        grade: 'B+',
      ),
      _TranscriptCourse(
        code: 'IF-302',
        name: 'Pemrograman Berorientasi Objek',
        sks: 3,
        grade: 'A',
      ),
      _TranscriptCourse(
        code: 'IF-303',
        name: 'Basis Data',
        sks: 3,
        grade: 'A',
      ),
      _TranscriptCourse(
        code: 'IF-304',
        name: 'Interaksi Manusia dan Komputer',
        sks: 2,
        grade: 'B',
      ),
    ],
  ),
];

class TranskripPage extends StatelessWidget {
  const TranskripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Transkrip'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Transkrip nilai',
            subtitle: '${_StudentData.name} · NIM ${_StudentData.nim}',
          ),
          const SizedBox(height: 18),
          const _GradientSummaryCard(
            label: 'Indeks Prestasi Kumulatif',
            value: '3.72',
            footnote: 'Total 84 SKS · 42 mata kuliah',
          ),
          const SizedBox(height: 26),
          ..._transcript.map(
            (semester) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        semester.label,
                        style: const TextStyle(
                          color: _ink,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${semester.sks} SKS · IP ${semester.ip}',
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...semester.courses.map(
                    (course) => Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 8),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    course.name,
                                    style: const TextStyle(
                                      color: _ink,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${course.code} · ${course.sks} SKS',
                                    style: const TextStyle(
                                      color: _muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            _TagPill(
                              label: course.grade,
                              color: _gradeColor(course.grade),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _logoutToLogin(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const LoginPage()),
    (route) => false,
  );
}

class TeacherClass {
  const TeacherClass({
    required this.name,
    required this.code,
    required this.room,
    required this.students,
  });

  final String name;
  final String code;
  final String room;
  final int students;
}

class TeacherMaterial {
  const TeacherMaterial({
    required this.classCode,
    required this.title,
    required this.week,
    required this.topic,
    required this.description,
  });

  final String classCode;
  final String title;
  final int week;
  final String topic;
  final String description;
}

class TeacherAssignment {
  const TeacherAssignment({
    required this.classCode,
    required this.title,
    required this.dueDate,
    required this.submitted,
    required this.total,
  });

  final String classCode;
  final String title;
  final String dueDate;
  final int submitted;
  final int total;
}

const _initialTeacherClasses = [
  TeacherClass(
    name: 'Bahasa Jepang',
    code: 'JP-N3-01',
    room: 'R. 3.02',
    students: 28,
  ),
  TeacherClass(
    name: 'Pemrograman Mobile',
    code: 'IF-501',
    room: 'Lab RPL',
    students: 34,
  ),
  TeacherClass(
    name: 'Basis Data Lanjut',
    code: 'IF-502',
    room: 'R. 2.11',
    students: 30,
  ),
];

const _initialTeacherMaterials = [
  TeacherMaterial(
    classCode: 'JP-N3-01',
    title: 'Pola Kalimat 〜のに',
    week: 1,
    topic: '文法',
    description: 'Latihan menyusun kalimat dengan 〜のに.',
  ),
  TeacherMaterial(
    classCode: 'JP-N3-01',
    title: 'Kosakata & Kanji',
    week: 2,
    topic: '語彙',
    description: 'Hafalan kosakata N3 dan 10 kanji baru.',
  ),
  TeacherMaterial(
    classCode: 'IF-501',
    title: 'Pengantar Flutter',
    week: 1,
    topic: 'Widget',
    description: 'Struktur project dan widget dasar Flutter.',
  ),
  TeacherMaterial(
    classCode: 'IF-502',
    title: 'Normalisasi Data',
    week: 3,
    topic: 'Basis Data',
    description: 'Normalisasi 1NF sampai 3NF beserta contoh.',
  ),
];

const _initialTeacherAssignments = [
  TeacherAssignment(
    classCode: 'IF-501',
    title: 'Implementasi REST API',
    dueDate: '27 Okt 2026',
    submitted: 21,
    total: 34,
  ),
  TeacherAssignment(
    classCode: 'JP-N3-01',
    title: 'Esai 作文 #2',
    dueDate: '30 Okt 2026',
    submitted: 12,
    total: 28,
  ),
  TeacherAssignment(
    classCode: 'IF-502',
    title: 'Query Lanjutan',
    dueDate: '25 Okt 2026',
    submitted: 30,
    total: 30,
  ),
];

class TeacherStore extends ChangeNotifier {
  final List<TeacherClass> classes = [..._initialTeacherClasses];
  final List<TeacherMaterial> materials = [..._initialTeacherMaterials];
  final List<TeacherAssignment> assignments = [..._initialTeacherAssignments];

  int get totalStudents => classes.fold(0, (sum, item) => sum + item.students);

  int get pendingGrading => assignments.fold(
    0,
    (sum, item) => sum + (item.total - item.submitted),
  );

  TeacherClass? classByCode(String code) {
    for (final item in classes) {
      if (item.code == code) return item;
    }
    return null;
  }

  String className(String code) => classByCode(code)?.name ?? code;

  List<TeacherMaterial> materialsFor(String code) =>
      materials.where((item) => item.classCode == code).toList();

  List<TeacherAssignment> assignmentsFor(String code) =>
      assignments.where((item) => item.classCode == code).toList();

  void addClass(TeacherClass item) {
    classes.add(item);
    notifyListeners();
  }

  void addMaterial(TeacherMaterial item) {
    materials.add(item);
    notifyListeners();
  }

  void addAssignment(TeacherAssignment item) {
    assignments.add(item);
    notifyListeners();
  }
}

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({super.key});

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  final TeacherStore _store = TeacherStore();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  void _selectTab(int index) => setState(() => _selectedIndex = index);

  Future<void> _createClass() async {
    final result = await Navigator.of(context).push<TeacherClass>(
      MaterialPageRoute(builder: (_) => const TeacherBuatKelasPage()),
    );
    if (result != null) _store.addClass(result);
  }

  Future<void> _createMaterial({String? initialClassCode}) async {
    final result = await Navigator.of(context).push<TeacherMaterial>(
      MaterialPageRoute(
        builder: (_) => TeacherBuatMateriPage(
          classes: _store.classes,
          initialClassCode: initialClassCode,
        ),
      ),
    );
    if (result != null) _store.addMaterial(result);
  }

  Future<void> _createAssignment({String? initialClassCode}) async {
    final result = await Navigator.of(context).push<TeacherAssignment>(
      MaterialPageRoute(
        builder: (_) => TeacherBuatTugasPage(
          classes: _store.classes,
          initialClassCode: initialClassCode,
        ),
      ),
    );
    if (result != null) _store.addAssignment(result);
  }

  void _openClass(TeacherClass item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => TeacherKelasDetailPage(
          store: _store,
          classCode: item.code,
          onCreateMaterial: _createMaterial,
          onCreateAssignment: _createAssignment,
        ),
      ),
    );
  }

  void _handleMenu(String label) {
    if (label == 'Manage Kelas') {
      _selectTab(1);
      return;
    }
    if (label == 'Buat Materi') {
      _selectTab(2);
      return;
    }
    if (label == 'Konsultasi') {
      _selectTab(3);
      return;
    }
    if (label == 'Tugas') {
      _createAssignment();
      return;
    }
    if (label == 'Presensi') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TeacherPresensiPage(store: _store)),
      );
      return;
    }
    if (label == 'Penilaian') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => TeacherPenilaianPage(store: _store)),
      );
      return;
    }
    if (label == 'Mahasiswa') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const TeacherMahasiswaPage()),
      );
      return;
    }
    if (label == 'Pengumuman') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const TeacherPengumumanPage()),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _TeacherDashboard(
            store: _store,
            onMenuTap: _handleMenu,
            onCreateClass: _createClass,
          ),
          TeacherKelasPage(store: _store, onAdd: _createClass, onOpen: _openClass),
          TeacherMateriPage(store: _store, onAdd: _createMaterial),
          const TeacherPesanPage(),
          const TeacherAccountPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectTab,
        backgroundColor: Colors.white,
        indicatorColor: _purple.withValues(alpha: .12),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Kelas',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Materi',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Pesan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}

class _TeacherDashboard extends StatelessWidget {
  const _TeacherDashboard({
    required this.store,
    required this.onMenuTap,
    required this.onCreateClass,
  });

  final TeacherStore store;
  final ValueChanged<String> onMenuTap;
  final VoidCallback onCreateClass;

  @override
  Widget build(BuildContext context) {
    final menu = [
      (Icons.groups_outlined, 'Manage Kelas', const Color(0xFFE5E1FF)),
      (Icons.menu_book_outlined, 'Buat Materi', const Color(0xFFE0F5EA)),
      (Icons.edit_note, 'Tugas', const Color(0xFFFFEBC9)),
      (Icons.qr_code_scanner_rounded, 'Presensi', const Color(0xFFE0F5F5)),
      (Icons.grading_outlined, 'Penilaian', const Color(0xFFE0F5EA)),
      (Icons.groups_2_outlined, 'Mahasiswa', const Color(0xFFD6ECFF)),
      (Icons.support_agent, 'Konsultasi', const Color(0xFFFFE7C2)),
      (Icons.campaign_outlined, 'Pengumuman', const Color(0xFFFFE1EC)),
    ];

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_purple, _violet],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: Text(
                            'AD',
                            style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Halo, admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Dosen · LMS Student',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          _DashboardStat(
                            label: 'Kelas',
                            value: '${store.classes.length}',
                          ),
                          _DashboardStat(
                            label: 'Mahasiswa',
                            value: '${store.totalStudents}',
                          ),
                          _DashboardStat(
                            label: 'Perlu koreksi',
                            value: '${store.pendingGrading}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kelola Pengajaran',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Atur kelas, materi, tugas, dan penilaian mahasiswa.',
                    style: TextStyle(color: _muted, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: menu.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 18,
                          childAspectRatio: .72,
                        ),
                    itemBuilder: (context, index) {
                      final item = menu[index];
                      return InkWell(
                        onTap: () => onMenuTap(item.$2),
                        borderRadius: BorderRadius.circular(14),
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: item.$3,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(item.$1, color: _purple, size: 28),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              item.$2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: _ink,
                                fontSize: 11,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton.icon(
                      onPressed: onCreateClass,
                      icon: const Icon(Icons.add),
                      label: const Text('Buat kelas baru'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardStat extends StatelessWidget {
  const _DashboardStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: _purple,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
        ],
      ),
    );
  }
}

class TeacherKelasPage extends StatelessWidget {
  const TeacherKelasPage({
    required this.store,
    required this.onAdd,
    required this.onOpen,
    super.key,
  });

  final TeacherStore store;
  final VoidCallback onAdd;
  final ValueChanged<TeacherClass> onOpen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Manage Kelas'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: [
            const _PageHeader(
              title: 'Kelola kelas',
              subtitle: 'Buat kelas dan atur materi, tugas, serta presensinya.',
            ),
            const SizedBox(height: 18),
            ...store.classes.map(
              (item) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
                child: InkWell(
                  onTap: () => onOpen(item),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: _purple.withValues(alpha: .1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.groups_outlined,
                            color: _purple,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: _ink,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.code} · ${item.room}',
                                style: const TextStyle(
                                  color: _muted,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.people_outline,
                                    size: 14,
                                    color: _muted,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${item.students} mahasiswa',
                                    style: const TextStyle(
                                      color: _muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: _muted),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAdd,
        backgroundColor: _purple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Buat kelas'),
      ),
    );
  }
}

class TeacherKelasDetailPage extends StatelessWidget {
  const TeacherKelasDetailPage({
    required this.store,
    required this.classCode,
    required this.onCreateMaterial,
    required this.onCreateAssignment,
    super.key,
  });

  final TeacherStore store;
  final String classCode;
  final Future<void> Function({String? initialClassCode}) onCreateMaterial;
  final Future<void> Function({String? initialClassCode}) onCreateAssignment;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final data = store.classByCode(classCode);
        if (data == null) {
          return Scaffold(
            backgroundColor: _background,
            appBar: AppBar(title: const Text('Kelas')),
            body: const Center(child: Text('Kelas tidak ditemukan.')),
          );
        }
        final materials = store.materialsFor(classCode);
        final assignments = store.assignmentsFor(classCode);

        return Scaffold(
          backgroundColor: _background,
          appBar: AppBar(
            title: Text(data.name),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            children: [
              Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ClassInfo(label: 'Kode', value: data.code),
                      ),
                      Expanded(
                        child: _ClassInfo(label: 'Ruang', value: data.room),
                      ),
                      Expanded(
                        child: _ClassInfo(
                          label: 'Mahasiswa',
                          value: '${data.students}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                title: 'Materi & sesi',
                onAdd: () => onCreateMaterial(initialClassCode: classCode),
              ),
              const SizedBox(height: 10),
              if (materials.isEmpty)
                const Text(
                  'Belum ada materi untuk kelas ini.',
                  style: TextStyle(color: _muted),
                ),
              ...materials.map(
                (item) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _purple.withValues(alpha: .12),
                      child: Text(
                        '${item.week}',
                        style: const TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text('Pertemuan ${item.week} · ${item.topic}'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _SectionHeader(
                title: 'Tugas',
                onAdd: () => onCreateAssignment(initialClassCode: classCode),
              ),
              const SizedBox(height: 10),
              if (assignments.isEmpty)
                const Text(
                  'Belum ada tugas untuk kelas ini.',
                  style: TextStyle(color: _muted),
                ),
              ...assignments.map(
                (item) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.white,
                  child: ListTile(
                    leading: const Icon(Icons.edit_note, color: _purple),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      'Tenggat ${item.dueDate} · ${item.submitted}/${item.total} terkumpul',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        TeacherPresensiPage(store: store, classCode: classCode),
                  ),
                ),
                icon: const Icon(Icons.qr_code_scanner_rounded),
                label: const Text('Presensi kelas ini'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ClassInfo extends StatelessWidget {
  const _ClassInfo({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: _ink,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onAdd});

  final String title;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Tambah'),
        ),
      ],
    );
  }
}

class TeacherMateriPage extends StatefulWidget {
  const TeacherMateriPage({required this.store, required this.onAdd, super.key});

  final TeacherStore store;
  final Future<void> Function({String? initialClassCode}) onAdd;

  @override
  State<TeacherMateriPage> createState() => _TeacherMateriPageState();
}

class _TeacherMateriPageState extends State<TeacherMateriPage> {
  String? _filter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Materi & Sesi'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListenableBuilder(
        listenable: widget.store,
        builder: (context, _) {
          final items = _filter == null
              ? widget.store.materials
              : widget.store.materialsFor(_filter!);
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            children: [
              const _PageHeader(
                title: 'Materi & sesi',
                subtitle: 'Buat materi pertemuan untuk tiap kelas.',
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('Semua'),
                    selected: _filter == null,
                    onSelected: (_) => setState(() => _filter = null),
                    selectedColor: _purple.withValues(alpha: .2),
                  ),
                  ...widget.store.classes.map(
                    (item) => ChoiceChip(
                      label: Text(item.name),
                      selected: _filter == item.code,
                      onSelected: (_) => setState(() => _filter = item.code),
                      selectedColor: _purple.withValues(alpha: .2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (items.isEmpty)
                const Text(
                  'Belum ada materi. Tekan "Buat materi" untuk menambah.',
                  style: TextStyle(color: _muted),
                ),
              ...items.map(
                (item) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: _purple.withValues(alpha: .1),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Center(
                                child: Text(
                                  '${item.week}',
                                  style: const TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: _ink,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.store.className(item.classCode)} · Pertemuan ${item.week}',
                                    style: const TextStyle(
                                      color: _muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _TagPill(
                              label: item.topic,
                              color: _purple,
                            ),
                          ],
                        ),
                        if (item.description.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            item.description,
                            style: const TextStyle(color: _ink, height: 1.4),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => widget.onAdd(),
        backgroundColor: _purple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Buat materi'),
      ),
    );
  }
}

class TeacherBuatKelasPage extends StatefulWidget {
  const TeacherBuatKelasPage({super.key});

  @override
  State<TeacherBuatKelasPage> createState() => _TeacherBuatKelasPageState();
}

class _TeacherBuatKelasPageState extends State<TeacherBuatKelasPage> {
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _roomController = TextEditingController();
  final _studentsController = TextEditingController(text: '0');

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _roomController.dispose();
    _studentsController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _nameController.text.trim();
    final code = _codeController.text.trim();
    final students = int.tryParse(_studentsController.text.trim()) ?? 0;
    if (name.isEmpty || code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama dan kode kelas wajib diisi.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.of(context).pop(
      TeacherClass(
        name: name,
        code: code,
        room: _roomController.text.trim().isEmpty
            ? '-'
            : _roomController.text.trim(),
        students: students,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Buat Kelas'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Kelas baru',
            subtitle: 'Lengkapi data kelas yang akan kamu ampu.',
          ),
          const SizedBox(height: 18),
          _InputField(
            controller: _nameController,
            label: 'Nama kelas',
            icon: Icons.groups_outlined,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _codeController,
            label: 'Kode kelas',
            icon: Icons.tag,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _roomController,
            label: 'Ruang',
            icon: Icons.meeting_room_outlined,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _studentsController,
            label: 'Jumlah mahasiswa',
            icon: Icons.people_outline,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: _purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simpan kelas',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherBuatMateriPage extends StatefulWidget {
  const TeacherBuatMateriPage({
    required this.classes,
    this.initialClassCode,
    super.key,
  });

  final List<TeacherClass> classes;
  final String? initialClassCode;

  @override
  State<TeacherBuatMateriPage> createState() => _TeacherBuatMateriPageState();
}

class _TeacherBuatMateriPageState extends State<TeacherBuatMateriPage> {
  final _titleController = TextEditingController();
  final _weekController = TextEditingController(text: '1');
  final _topicController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _classCode;

  @override
  void initState() {
    super.initState();
    _classCode = widget.initialClassCode ??
        (widget.classes.isNotEmpty ? widget.classes.first.code : null);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _weekController.dispose();
    _topicController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final week = int.tryParse(_weekController.text.trim());
    if (_classCode == null || title.isEmpty || week == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pilih kelas, isi judul, dan pertemuan ke-.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final topic = _topicController.text.trim();
    Navigator.of(context).pop(
      TeacherMaterial(
        classCode: _classCode!,
        title: title,
        week: week,
        topic: topic.isEmpty ? 'Umum' : topic,
        description: _descriptionController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Buat Materi & Sesi'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Materi & sesi baru',
            subtitle: 'Tambahkan materi pertemuan untuk sebuah kelas.',
          ),
          const SizedBox(height: 18),
          const Text(
            'Pilih kelas',
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.classes
                .map(
                  (item) => ChoiceChip(
                    label: Text('${item.name} · ${item.code}'),
                    selected: _classCode == item.code,
                    onSelected: (_) => setState(() => _classCode = item.code),
                    selectedColor: _purple.withValues(alpha: .2),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          _InputField(
            controller: _titleController,
            label: 'Judul materi',
            icon: Icons.menu_book_outlined,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _weekController,
            label: 'Pertemuan ke-',
            icon: Icons.numbers,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _topicController,
            label: 'Topik',
            icon: Icons.local_offer_outlined,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _descriptionController,
            label: 'Deskripsi',
            icon: Icons.notes_outlined,
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: _purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simpan materi',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherBuatTugasPage extends StatefulWidget {
  const TeacherBuatTugasPage({
    required this.classes,
    this.initialClassCode,
    super.key,
  });

  final List<TeacherClass> classes;
  final String? initialClassCode;

  @override
  State<TeacherBuatTugasPage> createState() => _TeacherBuatTugasPageState();
}

class _TeacherBuatTugasPageState extends State<TeacherBuatTugasPage> {
  final _titleController = TextEditingController();
  final _dueController = TextEditingController();
  String? _classCode;

  @override
  void initState() {
    super.initState();
    _classCode = widget.initialClassCode ??
        (widget.classes.isNotEmpty ? widget.classes.first.code : null);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dueController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final due = _dueController.text.trim();
    final selected = widget.classes
        .where((item) => item.code == _classCode)
        .toList();
    if (_classCode == null || title.isEmpty || due.isEmpty || selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lengkapi kelas, judul tugas, dan tenggat.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    Navigator.of(context).pop(
      TeacherAssignment(
        classCode: _classCode!,
        title: title,
        dueDate: due,
        submitted: 0,
        total: selected.first.students,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Buat Tugas'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Tugas baru',
            subtitle: 'Buat tugas untuk dikerjakan mahasiswa.',
          ),
          const SizedBox(height: 18),
          const Text(
            'Pilih kelas',
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.classes
                .map(
                  (item) => ChoiceChip(
                    label: Text('${item.name} · ${item.code}'),
                    selected: _classCode == item.code,
                    onSelected: (_) => setState(() => _classCode = item.code),
                    selectedColor: _purple.withValues(alpha: .2),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 18),
          _InputField(
            controller: _titleController,
            label: 'Judul tugas',
            icon: Icons.edit_note,
          ),
          const SizedBox(height: 14),
          _InputField(
            controller: _dueController,
            label: 'Tenggat (contoh: 30 Okt 2026)',
            icon: Icons.event_outlined,
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                backgroundColor: _purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Simpan tugas',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherPresensiPage extends StatelessWidget {
  const TeacherPresensiPage({required this.store, this.classCode, super.key});

  final TeacherStore store;
  final String? classCode;

  void _showQrDialog(
    BuildContext context,
    TeacherClass item,
    TeacherMaterial material,
  ) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(item.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data:
                  'LMS|SESSION|${item.code}|W${material.week}|${material.title}',
              size: 200,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              'Pertemuan ${material.week} · ${material.title}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: _muted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Presensi'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) {
          final classes = classCode == null
              ? store.classes
              : store.classes.where((item) => item.code == classCode).toList();
          final sessions = <(TeacherClass, TeacherMaterial)>[
            for (final item in classes)
              for (final material in store.materialsFor(item.code))
                (item, material),
          ];

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            children: [
              const _PageHeader(
                title: 'Sesi presensi',
                subtitle: 'Pantau kehadiran mahasiswa tiap sesi kelas.',
              ),
              const SizedBox(height: 18),
              if (sessions.isEmpty)
                const Text(
                  'Belum ada sesi. Buat materi terlebih dahulu.',
                  style: TextStyle(color: _muted),
                ),
              ...sessions.map((entry) {
                final item = entry.$1;
                final material = entry.$2;
                final present = material.week % 4 == 0
                    ? item.students
                    : item.students - (material.week % 4);
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      color: _ink,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Pertemuan ${material.week} · ${material.title}',
                                    style: const TextStyle(
                                      color: _muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () =>
                                  _showQrDialog(context, item, material),
                              icon: const Icon(Icons.qr_code, size: 18),
                              label: const Text('QR'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: item.students == 0
                                ? 0
                                : present / item.students,
                            minHeight: 8,
                            color: _purple,
                            backgroundColor: _purple.withValues(alpha: .12),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$present dari ${item.students} mahasiswa hadir',
                          style: const TextStyle(color: _muted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}

class TeacherPenilaianPage extends StatelessWidget {
  const TeacherPenilaianPage({required this.store, super.key});

  final TeacherStore store;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Penilaian'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListenableBuilder(
        listenable: store,
        builder: (context, _) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          children: [
            const _PageHeader(
              title: 'Koreksi tugas',
              subtitle: 'Beri nilai untuk tugas yang dikumpulkan mahasiswa.',
            ),
            const SizedBox(height: 18),
            ...store.assignments.map((item) {
              final pending = item.total - item.submitted;
              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    color: _ink,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${store.className(item.classCode)} · tenggat ${item.dueDate}',
                                  style: const TextStyle(
                                    color: _muted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _TagPill(
                            label: pending == 0
                                ? 'Selesai'
                                : '$pending perlu koreksi',
                            color: pending == 0
                                ? const Color(0xFF2E9E5B)
                                : const Color(0xFFE0A100),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: item.total == 0
                              ? 0
                              : item.submitted / item.total,
                          minHeight: 8,
                          color: _purple,
                          backgroundColor: _purple.withValues(alpha: .12),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${item.submitted} dari ${item.total} terkumpul',
                        style: const TextStyle(color: _muted, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Membuka lembar penilaian ${item.title}.',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              ),
                          icon: const Icon(Icons.grading_outlined, size: 18),
                          label: const Text('Koreksi'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class TeacherMahasiswaPage extends StatefulWidget {
  const TeacherMahasiswaPage({super.key});

  @override
  State<TeacherMahasiswaPage> createState() => _TeacherMahasiswaPageState();
}

class _TeacherMahasiswaPageState extends State<TeacherMahasiswaPage> {
  final _searchController = TextEditingController();
  String _query = '';

  static const _students = [
    ('LM', 'lulu malik', '221011400123', 'Bahasa Jepang'),
    ('RA', 'Rizky Ananda', '221011400187', 'Pemrograman Mobile'),
    ('NP', 'Nadia Putri', '221011400204', 'Basis Data Lanjut'),
    ('BS', 'Bagas Saputra', '221011400099', 'Pemrograman Mobile'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _query.toLowerCase();
    final items = _students
        .where(
          (item) =>
              item.$2.toLowerCase().contains(query) ||
              item.$3.contains(query),
        )
        .toList();

    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Mahasiswa'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const _PageHeader(
            title: 'Daftar mahasiswa',
            subtitle: 'Mahasiswa yang mengikuti kelas yang kamu ampu.',
          ),
          const SizedBox(height: 16),
          _InputField(
            controller: _searchController,
            label: 'Cari nama atau NIM',
            icon: Icons.search,
            onSubmitted: (value) => setState(() => _query = value.trim()),
          ),
          const SizedBox(height: 16),
          if (items.isEmpty)
            const Text('Tidak ada mahasiswa yang cocok.', style: TextStyle(color: _muted)),
          ...items.map(
            (item) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _purple.withValues(alpha: .15),
                  child: Text(
                    item.$1,
                    style: const TextStyle(
                      color: _purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  item.$2,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text('${item.$3} · ${item.$4}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherPengumumanPage extends StatefulWidget {
  const TeacherPengumumanPage({super.key});

  @override
  State<TeacherPengumumanPage> createState() => _TeacherPengumumanPageState();
}

class _TeacherPengumumanPageState extends State<TeacherPengumumanPage> {
  final List<(String, String, String)> _announcements = [
    (
      'Ujian tengah semester',
      'UTS Bahasa Jepang dilaksanakan 8 April 2026, pukul 08.00 di R. 3.02.',
      'Diumumkan 1 Apr 2026',
    ),
    (
      'Pengumpulan tugas',
      'Tenggat tugas Implementasi REST API diperpanjang hingga 27 Oktober 2026.',
      'Diumumkan 24 Okt 2026',
    ),
  ];

  void _addAnnouncement() {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Pengumuman baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bodyController,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Isi pengumuman'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              final title = titleController.text.trim();
              final body = bodyController.text.trim();
              if (title.isEmpty || body.isEmpty) return;
              setState(() {
                _announcements.insert(0, (title, body, 'Baru saja'));
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        title: const Text('Pengumuman'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        children: [
          const _PageHeader(
            title: 'Pengumuman kelas',
            subtitle: 'Bagikan informasi penting kepada mahasiswa.',
          ),
          const SizedBox(height: 18),
          ..._announcements.map(
            (item) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.campaign_outlined,
                          color: _purple,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.$1,
                            style: const TextStyle(
                              color: _ink,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.$2,
                      style: const TextStyle(color: _ink, height: 1.4),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.$3,
                      style: const TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addAnnouncement,
        backgroundColor: _purple,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Buat pengumuman'),
      ),
    );
  }
}

class TeacherPesanPage extends StatelessWidget {
  const TeacherPesanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = [
      ('LM', 'lulu malik', 'Mengajukan konsultasi topik REST API', '10 mnt'),
      ('RA', 'Rizky Ananda', 'Menanyakan revisi laporan praktikum', '1 jam'),
      ('NP', 'Nadia Putri', 'Meminta izin tidak mengikuti sesi', 'Kemarin'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesan'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.help_outline)),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView.separated(
        itemCount: messages.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = messages[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            leading: CircleAvatar(
              radius: 29,
              backgroundColor: _purple.withValues(alpha: .15),
              child: Text(
                item.$1,
                style: const TextStyle(
                  color: _purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              item.$2,
              style: const TextStyle(
                color: _ink,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              item.$3,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _muted),
            ),
            trailing: Text(
              item.$4,
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}

class TeacherAccountPage extends StatelessWidget {
  const TeacherAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.person_outline,
        'Kelola Profil',
        'Perbarui data dosen dan foto profil',
      ),
      (
        Icons.folder_copy_outlined,
        'Media Library',
        'Kelola materi dan berkas kelas',
      ),
      (Icons.grading_outlined, 'Penilaian', 'Atur bobot dan komponen nilai'),
      (Icons.settings_outlined, 'Pengaturan', 'Atur notifikasi dan preferensi'),
      (Icons.help_outline, 'FAQ', 'Pertanyaan yang sering ditanyakan'),
      (Icons.logout, 'Keluar', 'Keluar dari akun dosen'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const ListTile(
            contentPadding: EdgeInsets.fromLTRB(20, 18, 20, 14),
            leading: CircleAvatar(
              radius: 29,
              backgroundColor: _purple,
              child: Text(
                'AD',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              'admin',
              style: TextStyle(
                color: _ink,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('Dosen · LMS Student'),
          ),
          const Divider(height: 1),
          ...items.map(
            (item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8,
              ),
              leading: Icon(item.$1, color: _ink, size: 27),
              title: Text(
                item.$2,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                item.$3,
                style: const TextStyle(color: _muted, fontSize: 12),
              ),
              trailing: const Icon(Icons.chevron_right, color: _muted),
              onTap: item.$2 == 'Keluar'
                  ? () => _logoutToLogin(context)
                  : () {},
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text('Versi 1.0.0', style: TextStyle(color: _muted)),
          ),
        ],
      ),
    );
  }
}
