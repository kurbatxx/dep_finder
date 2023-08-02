import 'package:dep_finder/model/simple_node.dart';
import 'package:dep_finder/provider/deputat_id_provider.dart';
import 'package:dep_finder/provider/street_id_provider.dart';
import 'package:dep_finder/widget/buildings_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SearchDropdown extends StatefulWidget {
  final List<SimpleNode> nodes;
  const SearchDropdown({super.key, required this.nodes});

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  final textController = TextEditingController();

  @override
  void initState() {
    textController.addListener(() {
      print('change controller');
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    focus.dispose();
    textController.dispose();
    super.dispose();
  }

  final focus = FocusNode();

  @override
  Widget build(BuildContext context) {
    List<SimpleNode> filteredStreets = widget.nodes
        .where((element) => element.nodeName
            .toLowerCase()
            .contains(textController.text.toLowerCase()))
        .toList();

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(deputatIdProvider, (previous, next) {
          print("---LISSEN---");
          if (next == null) {
            return;
          }

          context.go('/dep_info');
        });

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(children: [
                Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Введите название улицы",
                        suffixIcon: IconButton(
                          onPressed: textController.clear,
                          splashRadius: 16.0,
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      controller: textController,
                      focusNode: focus,
                      onSubmitted: (value) {},
                    ),
                    const SizedBox(height: 4.0),
                    const Buildings()
                  ],
                ),
                if (focus.hasFocus) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.blueAccent)),
                      height: [
                        if (filteredStreets.length > 5) ...[
                          5 * 50
                        ] else if (filteredStreets.isEmpty) ...[
                          1 * 50
                        ] else ...[
                          filteredStreets.length * 50
                        ]
                      ].first.toDouble(),
                      child: filteredStreets.isEmpty
                          ? const ListTile(title: Text("Ничего не найдено"))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredStreets.length,
                              itemBuilder: (context, index) {
                                final street = filteredStreets[index];

                                return ListTile(
                                  onTap: () {
                                    ref.read(streetIdProvider.notifier).state =
                                        street.nodeId;

                                    ref.read(deputatIdProvider.notifier).state =
                                        street.deputatId;

                                    setState(() {
                                      textController.text = street.nodeName;
                                    });
                                  },
                                  title: Text(street.nodeName),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ]),
            ],
          ),
        );
      },
    );
  }
}
