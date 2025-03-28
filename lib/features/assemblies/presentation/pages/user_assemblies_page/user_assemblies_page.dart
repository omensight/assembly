import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/presentation/controllers/user_assemblies_list_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserAssembliesPage extends ConsumerWidget {
  const UserAssembliesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAssembliesAsync = ref.watch(userAssembliesListControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.assemblies.tr())),
      body: userAssembliesAsync.when(
        data: (assemblies) {
          return ListView.separated(
            separatorBuilder: (context, index) => StandardSpace.vertical(),
            itemBuilder: (context, index) => Row(),
            itemCount: assemblies.length,
          );
        },
        error: (error, stackTrace) => Center(child: Text(error as String)),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
