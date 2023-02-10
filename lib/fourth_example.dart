import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const names = [
  'Karl',
  'Friedrich',
  'Vladimir',
  'Joseph',
  'Rosa',
  'Antonio',
  'Domenico'
];

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(const Duration(seconds: 1), (i) => i + 1),
);
final namesProvider = StreamProvider(
  (ref) => ref.watch(tickerProvider.stream).map(
        (count) => names.getRange(0, count),
      ),
);

/// This example shows how to use StreamProviders.
/// namesProvider watches tickerProvider and for every
/// event emmited by the stream on tickerProvider,
/// namesProvider will get the <count> value and return
/// all the names in the list from 0 to <count>.
class FourthExample extends ConsumerWidget {
  const FourthExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fourth Example - StreamProvider"),
      ),
      body: names.when(
          data: (names) => ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(names.elementAt(index)),
                  )),
          error: (error, stackTrace) => const Text("End of the list"),
          loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              )),
    );
  }
}
