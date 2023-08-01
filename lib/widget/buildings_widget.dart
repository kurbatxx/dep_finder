import 'package:dep_finder/provider/simple_nodes_provider.dart';
import 'package:dep_finder/provider/street_id_provider.dart';
import 'package:dep_finder/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Buildings extends StatelessWidget {
  const Buildings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final steetId = ref.watch(streetIdProvider);
      if (steetId == null) {
        return const SizedBox();
      } else {
        final buidings = ref.watch(simpleNodesProvider(steetId));
        return buidings.when(
          loading: () => const Center(child: LoadingWidget()),
          error: (_, __) => const Center(
            child: Text("Не удалось загрузить данные"),
          ),
          data: (data) {
            return Wrap(
              children: [
                for (final item in data) Chip(label: Text(item.nodeName))
              ],
            );
          },
        );
      }
    });
  }
}
