import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Providers are declared globally and specify how to create a state
final counterProvider = StateProvider((ref) => 0);

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("RiverPod")),
      body: homeBody(context),
      floatingActionButton: floatingButton(ref),
    );
  }

  homeBody(BuildContext context) {
    return Center(
      // Consumer is a builder widget that allows you to read providers.
      child: Consumer(
        builder: (context, ref, _) {
          final count = ref.watch(counterProvider);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You have pushed the button this many times"),
              const SizedBox(height: 20),
              Text('$count'),
              const SizedBox(height: 20),
              resetButton(ref),
              productsButton(ref),
            ],
          );
        },
      ),
    );
  }

  floatingButton(WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(counterProvider.notifier).state++;
        final count = ref.watch(counterProvider);
        debugPrint("Counter Value: $count");
      },
      child: const Icon(Icons.add),
    );
  }

  resetButton(WidgetRef ref) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white60,
            minimumSize: const Size(100, 44),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4)))),
        onPressed: () {
          ref.read(counterProvider.notifier).state = 0;
        },
        child: const Text("Reset"));
  }

  productsButton(WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          ref.context.push('/products');
        },
        child: const Text("Products"));
  }
}
