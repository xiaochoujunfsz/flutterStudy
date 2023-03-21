class TimeRecord {
  //当前时刻
  final Duration record;

  //与上一刻差值
  final Duration addition;

  const TimeRecord({required this.record, required this.addition});
}
