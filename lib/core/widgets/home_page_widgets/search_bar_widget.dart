import 'package:flutter/material.dart';

import '../../resources/color_manager.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorManager.mainColor,
      decoration: const InputDecoration(
        hintText: 'Search product ...',
        prefixIcon: Icon(Icons.search),
      ),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
