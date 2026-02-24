import 'package:flutter/material.dart';

class CashCounterPage extends StatefulWidget {
  const CashCounterPage({super.key});

  @override
  State<CashCounterPage> createState() => _CashCounterPageState();
}

class _CashCounterPageState extends State<CashCounterPage> {
  final List<int> denominations = [2000, 500, 200, 100, 50, 10];
  final Map<int, int> counts = {};

  @override
  void initState() {
    super.initState();
    for (var d in denominations) {
      counts[d] = 0;
    }

    // Example initial values to match the screenshot feel (optional)
    counts[2000] = 20;
    counts[500] = 20;
    counts[200] = 20;
    counts[100] = 15;
  }

  void _increment(int denom) {
    setState(() => counts[denom] = (counts[denom] ?? 0) + 1);
  }

  void _decrement(int denom) {
    setState(() {
      final v = (counts[denom] ?? 0) - 1;
      counts[denom] = v < 0 ? 0 : v;
    });
  }

  int get totalNotes => counts.values.fold(0, (p, e) => p + e);

  int get grandTotal {
    var sum = 0;
    counts.forEach((denom, cnt) => sum += denom * cnt);
    return sum;
  }

  String _formatRu(int value) {
    // Simple Indian-style formatting (without package intl)
    final s = value.toString();
    if (s.length <= 3) return s;
    final last3 = s.substring(s.length - 3);
    var rest = s.substring(0, s.length - 3);
    final parts = <String>[];
    while (rest.length > 2) {
      parts.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) parts.insert(0, rest);
    return '${parts.join(',')},$last3';
  }

  void _reset() {
    setState(() {
      for (var k in denominations) {
        counts[k] = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF07140D);
    final darkCard = const Color(0xFF0F281F);
    final greenStart = const Color(0xFF13E77E);
    final greenEnd = const Color(0xFF00C853);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF062014),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text('Cash Counter'),
        actions: [
          TextButton(
            onPressed: _reset,
            child: const Text(
              'RESET',
              style: TextStyle(color: Color(0xFF26E57F)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(colors: [greenStart, greenEnd]),
                      boxShadow: [
                        BoxShadow(
                          color: greenStart.withAlpha((0.18 * 255).round()),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'GRAND TOTAL',
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '₹',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _formatRu(grandTotal),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(
                              Icons.note,
                              color: Colors.white70,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Total Notes: $totalNotes',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'DENOMINATIONS',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.separated(
                      itemCount: denominations.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final denom = denominations[index];
                        final cnt = counts[denom] ?? 0;
                        final subtotal = denom * cnt;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: darkCard,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.green.shade900.withAlpha(
                                (0.3 * 255).round(),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '₹$denom',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₹${_formatRu(subtotal)}',
                                    style: const TextStyle(
                                      color: Color(0xFF26E57F),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF05140C),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => _decrement(denom),
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Color(0xFF26E57F),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF0A371F),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        '$cnt',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => _increment(denom),
                                      icon: const Icon(
                                        Icons.add,
                                        color: Color(0xFF26E57F),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Save Button at bottom center
            Positioned(
              left: 16,
              right: 16,
              bottom: 70,
              child: ElevatedButton(
                onPressed: () {
                  // Placeholder: save logic can be implemented to persist the calculation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Calculation saved')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: greenStart,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save, color: Colors.black),
                    SizedBox(width: 12),
                    Text(
                      'SAVE CALCULATION',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF05140C),
        selectedItemColor: const Color(0xFF26E57F),
        unselectedItemColor: Colors.white38,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Counter',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: 0,
        onTap: (i) {},
      ),
    );
  }
}
