import 'package:flutter/material.dart';

class AnimatedBranding extends StatefulWidget {
  const AnimatedBranding({super.key, required this.style});

  final TextStyle style;

  @override
  State<AnimatedBranding> createState() => _AnimatedBrandingState();
}

class _AnimatedBrandingState extends State<AnimatedBranding> {
  final List<double> opacities = [0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      for (int i = 0; i < opacities.length; i++) {
        Future.delayed(Duration(milliseconds: (i + 1) * 300), () {
          if (mounted) {
            setState(() {
              opacities[i] = 1;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration = Duration(milliseconds: 400);
    return Column(
      spacing: 10,
      children: [
        AnimatedOpacity(
          opacity: opacities[0],
          duration: duration,
          child: Text("Seamlessly manage your", style: widget.style),
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: duration,
              opacity: opacities[0],
              child: Text(
                "Google",
                style: widget.style.copyWith(color: Colors.red),
              ),
            ),
            AnimatedOpacity(
              duration: duration,
              opacity: opacities[1],
              child: Text(
                "Drive",
                style: widget.style.copyWith(color: Colors.yellow.shade700),
              ),
            ),
            AnimatedOpacity(
              duration: duration,
              opacity: opacities[2],
              child: Text(
                "Text",
                style: widget.style.copyWith(color: Colors.green),
              ),
            ),
            AnimatedOpacity(
              duration: duration,
              opacity: opacities[3],
              child: Text(
                "Notes",
                style: widget.style.copyWith(color: Colors.blue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
