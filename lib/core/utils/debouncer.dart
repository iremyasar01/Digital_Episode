// core/utils/debouncer.dart
import 'dart:async';

/// Debouncer sınıfı - ardışık çağrıları geciktirerek performansı optimize eder
/// Özellikle arama işlemlerinde kullanıcı yazmayı bitirmeden API çağrısı yapılmasını engeller
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  /// Fonksiyonu çalıştırır, önceki timer'ı iptal eder
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Timer'ı temizler
  void dispose() {
    _timer?.cancel();
  }
}