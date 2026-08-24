class FeelingPost {
  final String id;
  final String text;
  final String emoji;
  final String mood;
  final DateTime timestamp;

  FeelingPost({
    required this.id,
    required this.text,
    required this.emoji,
    required this.mood,
    required this.timestamp,
  });
}

// In-memory data store for the session
class FeelingsRepository {
  static final List<FeelingPost> _posts = [
    FeelingPost(
      id: '1',
      text: 'I woke up feeling incredibly refreshed today. It\'s going to be a good day.',
      emoji: '🌅',
      mood: 'Hopeful',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    FeelingPost(
      id: '2',
      text: 'Feeling a bit overwhelmed with all the tasks I have to do this week.',
      emoji: '😰',
      mood: 'Anxious',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    ),
  ];

  static List<FeelingPost> get posts => List.unmodifiable(_posts);

  static void addPost(FeelingPost post) {
    _posts.insert(0, post);
  }
}
