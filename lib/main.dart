import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessBmiApp());
}

class FitnessBmiApp extends StatelessWidget {
  const FitnessBmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI & Health Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const BmiCalculatorScreen(),
    );
  }
}

class BmiCalculatorScreen extends StatefulWidget {
  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  bool _isMale = true;
  double _heightCm = 175;
  int _weightKg = 68;
  int _age = 22;

  double get _bmi => _weightKg / pow(_heightCm / 100, 2);

  String get _bmiStatus {
    if (_bmi < 18.5) return 'Underweight';
    if (_bmi < 25.0) return 'Normal Weight';
    if (_bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  Color get _statusColor {
    if (_bmi < 18.5) return Colors.blue;
    if (_bmi < 25.0) return Colors.green;
    if (_bmi < 30.0) return Colors.orange;
    return Colors.red;
  }

  String get _healthAdvice {
    if (_bmi < 18.5) {
      return 'Your body weight is lower than normal. Consider a balanced calorie-surplus diet.';
    } else if (_bmi < 25.0) {
      return 'Great job! You have a healthy body weight. Keep up your regular activity.';
    } else if (_bmi < 30.0) {
      return 'Slightly above normal range. Regular cardio and mindful nutrition will help.';
    }
    return 'High BMI detected. Consult a specialist for a structured fitness plan.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI & Health Tracker'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isMale = true),
                    child: Card(
                      color: _isMale ? Colors.green.shade100 : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.male,
                              size: 44,
                              color: _isMale
                                  ? Colors.green.shade800
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Male',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isMale = false),
                    child: Card(
                      color: !_isMale ? Colors.green.shade100 : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.female,
                              size: 44,
                              color: !_isMale
                                  ? Colors.green.shade800
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Female',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Height',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_heightCm.round()} cm',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _heightCm,
                      min: 120,
                      max: 220,
                      onChanged: (val) => setState(() => _heightCm = val),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildCounterCard(
                    label: 'Weight (kg)',
                    value: _weightKg,
                    onDecrement: () => setState(() {
                      if (_weightKg > 30) _weightKg--;
                    }),
                    onIncrement: () => setState(() => _weightKg++),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildCounterCard(
                    label: 'Age',
                    value: _age,
                    onDecrement: () => setState(() {
                      if (_age > 10) _age--;
                    }),
                    onIncrement: () => setState(() => _age++),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _statusColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _statusColor, width: 1.5),
              ),
              child: Column(
                children: [
                  Text(
                    _bmiStatus.toUpperCase(),
                    style: TextStyle(
                      color: _statusColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                      color: _statusColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _healthAdvice,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterCard({
    required String label,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Text(
              '$value',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filledTonal(
                  onPressed: onDecrement,
                  icon: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10),
                IconButton.filledTonal(
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
