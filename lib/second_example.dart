import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final self = this;
    if (self != null) {
      return (self ?? 0) + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

class Counter extends StateNotifier<int?> {
  Counter(super.state);
  void increment() => state = state == null ? 1 : state + 1;
}

final provider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(null),
);

/// This example shows how to use StateNotifier and StateNotifier provider.
/// The onPressed method of TextButton updates the state, while the Consumer widget
/// wrapped around the Center widget watches these changes in the state and updates
/// only this part of the widget tree when State changes.
class SecondExample extends ConsumerWidget {
  const SecondExample({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "2nd Example: StateNotifierProvider",
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        TextButton(
          onPressed: ref.read(provider.notifier).increment,
          child: const Text("increment"),
        ),
        Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(provider);
            final msg = count == null ? "Press the button" : count.toString();
            return Center(
              child: Text(msg),
            );
          },
        ),
      ]),
    );
  }
}
