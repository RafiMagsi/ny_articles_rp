import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedProductIdProvider = StateProvider<String?>((ref) => null);
final productCounter = StateProvider<int>((ref) => 1);
final productsProvider = StateNotifierProvider<ProductsNotifier, List<Product>>((ref) => ProductsNotifier());

class ProductsView extends ConsumerWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Product> products = ref.watch(productsProvider);
    final selectedProductId = ref.watch(selectedProductIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  for (final product in products)
                    GestureDetector(
                      onTap: () => ref.read(selectedProductIdProvider.notifier).state = product.id,
                      child: ProductItem(
                        product: product,
                        isSelected: selectedProductId == product.id,
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  int? counter = ref.read(productCounter.notifier).state++;
                  ref.read(productsProvider.notifier).addProduct(Product("TaifPay", counter.toString()));
                },
                child: const Text("Add Product")),
          ],
        ),
      ),
    );
  }

  Widget ProductItem({required Product product, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black12 : Colors.blueGrey[50],
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          Text('${product.id}'),
          const SizedBox(width: 10),
          Text('${product.name}'),
        ],
      ),
    );
  }
}

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]);

  void addProduct(Product personModel) {
    state = [...state, personModel];
  }
}

class Product {
  Product(this.name, this.id);
  final String? name;
  final String? id;
}
