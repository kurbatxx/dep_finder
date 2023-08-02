import 'package:dep_finder/provider/deputat_id_provider.dart';
import 'package:dep_finder/provider/deputat_provider.dart';
import 'package:dep_finder/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeputatWidget extends StatelessWidget {
  const DeputatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final id = ref.read(deputatIdProvider);
        final dep = ref.watch(deputatProvider(id ?? 1));

        return Scaffold(
          appBar: AppBar(
            title: const Text("Ваш депутат"),
            centerTitle: true,
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  ref.read(deputatIdProvider.notifier).state = null;
                  context.go("/");
                }),
          ),
          body: dep.when(
            data: (data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Center(child: Text(data.deputatName.toUpperCase())),
                    Center(child: Text("Номер участка: ${data.uchNumber}"))
                  ],
                ),
              );
            },
            error: (_, __) => const Center(
              child: Text("Депутат не найден"),
            ),
            loading: () => const Center(
              child: LoadingWidget(),
            ),
          ),
        );
      },
    );
  }
}
