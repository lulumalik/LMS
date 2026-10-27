import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lms/main.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  testWidgets('login remains quiet when fields are empty', (tester) async {
    await tester.pumpWidget(const LmsApp());

    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Selamat Datang Kembali'), findsOneWidget);
    expect(find.text('Username atau password belum sesuai.'), findsNothing);
  });

  testWidgets('valid dummy credentials open the dashboard', (tester) async {
    await tester.pumpWidget(const LmsApp());

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'user');
    await tester.enterText(fields.at(1), 'asdf1234');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('MyAcademic'), findsOneWidget);
    expect(find.text('Presensi QR'), findsOneWidget);
  });

  testWidgets('presensi QR page renders a scannable code', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PresensiQrPage()));
    await tester.pump();

    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text('lulu malik'), findsOneWidget);
    expect(find.text('Perbarui QR'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });

  testWidgets('student card reflects the current student data', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: KartuMahasiswaPage()));
    await tester.pump();

    expect(find.text('lulu malik'), findsWidgets);
    expect(find.text('PJJ Informatika'), findsWidgets);
    expect(find.text('221011400123'), findsWidgets);
    expect(find.text('LM'), findsOneWidget);
  });
}
