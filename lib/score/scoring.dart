class Score{
  final titleMatch;
  final shortA;
  final shortB;
  final teamAFlag;
  final teamBFlag;
  final scoreA;
  final wicketA;
  final oversA;
  final scoreB;
  final wicketB;
  final oversB;
  final String status;

  Score({
    required this.oversB,
    required this.oversA,
    required this.titleMatch,
    required this.shortA,
    required this.shortB,
    required this.teamAFlag,
    required this.teamBFlag,
    required this.scoreA,
    required this.wicketA,
    required this.scoreB,
    required this.wicketB,
    required this.status,
  });
}