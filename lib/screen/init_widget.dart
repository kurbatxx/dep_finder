import 'package:dep_finder/provider/simple_nodes_provider.dart';
import 'package:dep_finder/screen/search_dropdown.dart';
import 'package:dep_finder/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InitWidget extends StatelessWidget {
  const InitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Поиск депутата"),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final connection = ref.watch(simpleNodesProvider(19));

          return connection.when(
            data: (data) => SearchDropdown(nodes: data),
            error: (_, __) => const Center(
              child: Text("Не удалось загрузить данные"),
            ),
            loading: () => const Center(
              child: LoadingWidget(),
            ),
          );
        },
      ),
    );
  }
}
