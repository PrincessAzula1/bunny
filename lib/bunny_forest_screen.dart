import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class BunnyForestScreen extends StatefulWidget {
  final AudioPlayer musicPlayer;

  const BunnyForestScreen({Key? key, required this.musicPlayer})
      : super(key: key);

  @override
  State<BunnyForestScreen> createState() => _BunnyForestScreenState();
}

class _BunnyForestScreenState extends State<BunnyForestScreen> {
  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐰 Bunny game'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _goBack,
        ),
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFF2d5016),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '🐰 Welcome to Bunny Forest!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const GameBoardWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameBoardWidget extends StatefulWidget {
  const GameBoardWidget({Key? key}) : super(key: key);

  @override
  State<GameBoardWidget> createState() => _GameBoardWidgetState();
}

class _GameBoardWidgetState extends State<GameBoardWidget> {
  late List<GameBunny> bunnies;
  late List<GameTree> trees;
  int score = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    bunnies = [
      GameBunny(x: 200, y: 400),
      GameBunny(x: 400, y: 400),
      GameBunny(x: 600, y: 400),
    ];

    trees = [
      GameTree(x: 150, y: 150),
      GameTree(x: 350, y: 120),
      GameTree(x: 550, y: 140),
      GameTree(x: 750, y: 130),
      GameTree(x: 950, y: 150),
    ];
  }

  void _onCanvasTap(Offset position) {
    for (var bunny in bunnies) {
      final dx = bunny.x - position.dx;
      final dy = bunny.y - position.dy;
      final distance = sqrt(dx * dx + dy * dy);

      if (distance < 30) {
        setState(() {
          score += 10;
          bunny.x = 50 + (Random().nextDouble() * 800);
          bunny.y = 300 + (Random().nextDouble() * 200);
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _onCanvasTap(details.localPosition),
      child: CustomPaint(
        painter: GameBoardPainter(
          bunnies: bunnies,
          trees: trees,
          score: score,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class GameBunny {
  double x;
  double y;

  GameBunny({required this.x, required this.y});
}

class GameTree {
  double x;
  double y;

  GameTree({required this.x, required this.y});
}

class GameBoardPainter extends CustomPainter {
  final List<GameBunny> bunnies;
  final List<GameTree> trees;
  final int score;

  GameBoardPainter({
    required this.bunnies,
    required this.trees,
    required this.score,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw sky
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height * 0.4),
      Paint()..color = const Color(0xFF87ceeb),
    );

    // Draw grass
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.4, size.width, size.height * 0.6),
      Paint()..color = const Color(0xFF3d7a1f),
    );

    // Draw trees
    for (var tree in trees) {
      // Trunk
      canvas.drawRect(
        Rect.fromLTWH(tree.x - 10, tree.y, 20, 80),
        Paint()..color = const Color(0xFF654321),
      );

      // Foliage
      canvas.drawCircle(
        Offset(tree.x, tree.y - 20),
        30,
        Paint()..color = const Color(0xFF228B22),
      );
    }

    // Draw bunnies
    for (var bunny in bunnies) {
      // Body
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(bunny.x, bunny.y),
          width: 40,
          height: 30,
        ),
        Paint()..color = const Color(0xFFff9999),
      );

      // Head
      canvas.drawCircle(
        Offset(bunny.x, bunny.y - 25),
        15,
        Paint()..color = const Color(0xFFff9999),
      );

      // Ears
      canvas.drawRect(
        Rect.fromLTWH(bunny.x - 8, bunny.y - 50, 5, 25),
        Paint()..color = const Color(0xFFff9999),
      );
      canvas.drawRect(
        Rect.fromLTWH(bunny.x + 3, bunny.y - 50, 5, 25),
        Paint()..color = const Color(0xFFff9999),
      );

      // Eyes
      canvas.drawCircle(
        Offset(bunny.x - 6, bunny.y - 27),
        3,
        Paint()..color = Colors.black,
      );
      canvas.drawCircle(
        Offset(bunny.x + 6, bunny.y - 27),
        3,
        Paint()..color = Colors.black,
      );
    }

    // Draw score
    final textPainter = TextPainter(
      text: TextSpan(
        text: '🌟 Score: $score',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(20, 20));

    // Draw instructions
    final instructionPainter = TextPainter(
      text: const TextSpan(
        text: '💡 Tap bunnies to collect carrots!',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    instructionPainter.layout();
    instructionPainter.paint(canvas, Offset(20, size.height - 40));
  }

  @override
  bool shouldRepaint(GameBoardPainter oldDelegate) => true;
}
