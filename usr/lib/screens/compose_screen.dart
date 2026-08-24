import 'package:flutter/material.dart';
import '../models/feeling_post.dart';

class ComposeScreen extends StatefulWidget {
  const ComposeScreen({super.key});

  @override
  State<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  final TextEditingController _textController = TextEditingController();
  
  final List<Map<String, String>> _moods = [
    {'emoji': '😊', 'mood': 'Happy'},
    {'emoji': '😢', 'mood': 'Sad'},
    {'emoji': '😠', 'mood': 'Angry'},
    {'emoji': '😰', 'mood': 'Anxious'},
    {'emoji': '😌', 'mood': 'Calm'},
    {'emoji': '🥳', 'mood': 'Excited'},
    {'emoji': '🙏', 'mood': 'Grateful'},
    {'emoji': '😴', 'mood': 'Tired'},
  ];

  Map<String, String>? _selectedMood;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select how you are feeling')),
      );
      return;
    }
    
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please share some thoughts')),
      );
      return;
    }

    final newPost = FeelingPost(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: _textController.text.trim(),
      emoji: _selectedMood!['emoji']!,
      mood: _selectedMood!['mood']!,
      timestamp: DateTime.now(),
    );

    FeelingsRepository.addPost(newPost);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How are you feeling?'),
        actions: [
          TextButton(
            onPressed: _submit,
            child: const Text(
              'Post',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I am feeling...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _moods.map((mood) {
                      final isSelected = _selectedMood == mood;
                      return ChoiceChip(
                        label: Text('${mood['emoji']} ${mood['mood']}'),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedMood = selected ? mood : null;
                          });
                        },
                        selectedColor: Theme.of(context).colorScheme.primaryContainer,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected 
                              ? Theme.of(context).colorScheme.primary 
                              : Colors.grey.shade300,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Because...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _textController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Share your thoughts, completely unfiltered...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
