class ExerciseSet {
  final int reps;
  final double weight;
  final DateTime timestamp;

  ExerciseSet({required this.reps, required this.weight, required this.timestamp});

  Map<String, dynamic> toJson() => {
    'reps': reps,
    'weight': weight,
    'timestamp': timestamp.toIso8601String(),
  };

  factory ExerciseSet.fromJson(Map<String, dynamic> json) {
    return ExerciseSet(
      reps: json['reps'],
      weight: json['weight'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class Exercise {
  final String name;
  final List<ExerciseSet> sets;

  Exercise({required this.name, required this.sets});

  Map<String, dynamic> toJson() => {
    'name': name,
    'sets': sets.map((s) => s.toJson()).toList(),
  };

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      sets: (json['sets'] as List)
          .map((e) => ExerciseSet.fromJson(e))
          .toList(),
    );
  }
}