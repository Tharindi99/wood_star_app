import 'package:flutter/material.dart';

class QuizOptionTile extends StatelessWidget {
  final int index;
  final String imageUrl;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;
  final Color green;

  const QuizOptionTile({
    super.key,
    required this.index,
    required this.imageUrl,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
    required this.green,
  });

  bool get _isNetwork =>
      imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          /// Image Container
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _isNetwork
                    ? Image.network(imageUrl, fit: BoxFit.cover)
                    : Image.asset(imageUrl, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? (isCorrect ? green : Colors.red)
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Overlay Color
          if (isSelected)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isCorrect
                    ? green.withOpacity(0.35)
                    : Colors.red.withOpacity(0.35),
              ),
            ),

          /// Correct / Wrong Icon
          if (isSelected)
            Positioned.fill(
              child: Center(
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: isCorrect ? green : Colors.red,
                  child: Icon(
                    isCorrect ? Icons.check : Icons.close,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),

          /// Option Number
          Positioned(
            top: 8,
            left: 8,
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Colors.white,
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
