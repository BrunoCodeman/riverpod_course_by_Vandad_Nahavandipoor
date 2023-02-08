import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final Provider<DateTime> currentDate = Provider((ref) => DateTime.now());

class FirstExample extends ConsumerWidget {
  const FirstExample();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Example - Simple provider"),
      ),
      body: Center(
        child: Text(
          date.toIso8601String(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
