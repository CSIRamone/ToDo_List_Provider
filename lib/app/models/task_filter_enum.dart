enum TaskFilterEnum { today, tomorrow, week }

extension TaskFilterEnumExtension on TaskFilterEnum {
  String get label {
    switch (this) {
      case TaskFilterEnum.today:
        return ' DE HOJE';
      case TaskFilterEnum.tomorrow:
        return 'DE AMANHÃ';
      case TaskFilterEnum.week:
        return 'DA SEMANA';
    }
  }
}