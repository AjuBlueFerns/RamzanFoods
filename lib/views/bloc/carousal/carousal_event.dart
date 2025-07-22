abstract class CarousalEvent {}

class FetchCarousal extends CarousalEvent {}

class UpdateIndex extends CarousalEvent {
  final int index;
  UpdateIndex({
    required this.index,
  });
}

class IncrementIndex extends CarousalEvent {}
