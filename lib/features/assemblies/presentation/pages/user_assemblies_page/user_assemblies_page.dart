import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_actions_notifier.dart';
import 'package:assembly/core/widgets/standard_adaptable_width_container.dart';
import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/presentation/controllers/user_assemblies_list_controller.dart';
import 'package:assembly/features/assemblies/routes.dart';
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
      appBar: AppBar(
        title: Text(LocaleKeys.assemblies.tr()),
        actions: [
          StandardIconButton(
            icon: Icon(Icons.add_box_rounded),
            onPressed: () {
              CreateAssemblyRoute().push(context);
            },
          ),
          StandardIconButton(
            icon: Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {
              ScanAssemblyJoinCodeRoute().push(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: standardHorizontalPadding,
        child: SingleChildScrollView(
          child: StandardAdaptableWidthContainer(
            child: StandardActionsNotifier(
              child: userAssembliesAsync.when(
                data: (assemblies) {
                  return ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder:
                        (context, index) => StandardSpace.vertical(),
                    itemBuilder: (context, index) {
                      final currentItem = assemblies[index];
                      return AssemblyItemWidget(
                        assembly: currentItem,
                        onTap: () {
                          AssemblyDetailRoute(
                            assemblyId: currentItem.id,
                          ).push(context);
                        },
                      );
                    },
                    itemCount: assemblies.length,
                  );
                },
                error:
                    (error, stackTrace) => Center(child: Text(error as String)),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AssemblyItemWidget extends StatelessWidget {
  const AssemblyItemWidget({super.key, required this.assembly, this.onTap});

  final Assembly assembly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return StandardContainer(
      padding: EdgeInsets.all(8),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(assembly.name, style: Theme.of(context).textTheme.titleMedium),
          Text(assembly.address),
        ],
      ),
    );
  }
}
