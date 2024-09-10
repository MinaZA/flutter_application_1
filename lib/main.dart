import 'package:flutter/material.dart';
import 'login_page.dart'; // Import de la page de connexion

void main() {
  runApp(const CookieClickerApp());
}

class CookieClickerApp extends StatelessWidget {
  const CookieClickerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cookie Clicker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const LoginPage(), // Démarre sur la page de connexion
    );
  }
}

class CookieClickerPage extends StatefulWidget {
  const CookieClickerPage({Key? key}) : super(key: key);

  @override
  CookieClickerPageState createState() => CookieClickerPageState();
}

class CookieClickerPageState extends State<CookieClickerPage> with SingleTickerProviderStateMixin {
  int _cookieCount = 0;
  final int _maxClicks = 70;
  bool _isGameOver = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCookieCount() {
    if (_isGameOver) return;

    setState(() {
      if (_cookieCount < _maxClicks) {
        _cookieCount++;
        _controller.forward().then((_) {
          _controller.reverse();
        });

        if (_cookieCount >= _maxClicks) {
          _isGameOver = true;
        }
      }
    });
  }

  void _restartGame() {
    setState(() {
      _cookieCount = 0;
      _isGameOver = false;
      _controller.reset();
      _controller.forward().then((_) {
        _controller.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final int _clicksRemaining = _maxClicks - _cookieCount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookie Clicker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Lorsqu'on appuie sur le bouton déconnexion, on revient à la page de connexion
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cookies: $_cookieCount',
              style: const TextStyle(fontSize: 24),
            ),
            Text(
              'Clicks restants: $_clicksRemaining',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            _isGameOver
                ? Column(
                    children: [
                      const Text(
                        'Terminé',
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _restartGame,
                        child: const Text('Restart'),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: _incrementCookieCount,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animation.value,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        'assets/cookie.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
