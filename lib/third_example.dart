import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City {
  Stockholm,
  Paris,
  Tokyo,
}

typedef WeatherEmoji = String;
Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(const Duration(seconds: 1),
      () => {City.Stockholm: '❅', City.Paris: '⛈', City.Tokyo: '💨'}[city]!);
}

const unknownWeatherEmoji = "🤷🏽‍♂️";

//Will be read by the UI
final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(currentCityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);

//UI writes to and reads from this provider
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

/// This example uses a FutureProvider to watch a StateProvider.
/// Whenever the city changes on StateProvider, FutureProvider will return
///the weather of that city.
class ThirdExample extends ConsumerWidget {
  const ThirdExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text("3rd Example - Future Provider"),
        ),
        body: Column(
          children: [
            currentWeather.when(
              data: (data) => Text(
                data,
                style: const TextStyle(fontSize: 40),
              ),
              error: (error, stackTrace) =>
                  Text("${error.toString()} - ${stackTrace.toString()})"),
              loading: () => const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: City.values.length,
                  itemBuilder: (context, index) {
                    final city = City.values[index];
                    final provider = ref.watch(currentCityProvider);
                    final isSelected = city == provider;
                    return ListTile(
                      title: Text(city.name),
                      trailing: isSelected ? const Icon(Icons.check) : null,
                      onTap: () =>
                          ref.read(currentCityProvider.notifier).state = city,
                    );
                  }),
            ),
          ],
        ));
  }
}
