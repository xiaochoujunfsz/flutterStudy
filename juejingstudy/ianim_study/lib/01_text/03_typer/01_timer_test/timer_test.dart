import 'dart:async';

int count = 0;

main() {
  Timer.periodic(Duration(seconds: 1), (timer) {
    count++;
    print("------${DateTime.now().toIso8601String()}---------");
    if (count >= 10) {
      timer.cancel();
    }
  });
}
