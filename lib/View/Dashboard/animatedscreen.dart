import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({super.key});

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<String> _images = [
    'assets/banner.png',
    'assets/bannertwo.png',
    'assets/bannerthree.png',
    'assets/bannerfr.png',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSwap();

    // Initialize the animation controller for the marquee text
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: -1.0).animate(_controller);

    _controller.repeat();
  }

  void _startAutoSwap() {
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                  child: Text(
                    'Welcome! MFADII APP SHOP NOW',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 180,
            width: double.infinity,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 4),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Image.asset(
                _images[_currentIndex],
                key: ValueKey<int>(_currentIndex),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
            ),
          ),
          // Marquee Text
        ],
      ),
    );
  }
}
