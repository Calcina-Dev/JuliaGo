import 'package:flutter/material.dart';
import 'package:mobile_app/constants/app_styles.dart';

class NeumorphicToggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NeumorphicToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<NeumorphicToggle> createState() => _NeumorphicToggleState();
}

class _NeumorphicToggleState extends State<NeumorphicToggle> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.value;
  }

  void _toggle() {
    setState(() => _isOn = !_isOn);
    widget.onChanged(_isOn);
  }

  @override
  Widget build(BuildContext context) {
    const baseColor = AppStyles.backgroundColor;
    const lightShadow = Colors.white;
    const darkShadow = Color(0xFFDADFE3);

    return GestureDetector(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 100,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: lightShadow,
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
            BoxShadow(color: darkShadow, offset: Offset(4, 4), blurRadius: 10),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Texto fijo ON y OFF
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "ON",
                    style: TextStyle(
                      color: !_isOn
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    "OFF",
                    style: TextStyle(
                      color: _isOn
                          ? Colors.grey.shade300
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            // Círculo deslizante
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: _isOn ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 🔘 Círculo base
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: baseColor,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-2, -2),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color(0xFFDADFE3),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    // 🔴🟢 Punto de estado encima
                    Positioned(
                      //top: 6,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isOn ? Colors.green : Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: (_isOn ? Colors.green : Colors.red)
                                  .withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
