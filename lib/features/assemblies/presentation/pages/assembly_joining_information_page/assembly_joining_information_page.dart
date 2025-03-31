import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assembly_join_code_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/single_assembly_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AssemblyJoiningInformationPage extends ConsumerWidget {
  final String assemblyId;
  const AssemblyJoiningInformationPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblyJoinCodeAsync = ref.watch(
      assemblyJoinCodeControllerProvider(assemblyId),
    );
    final assemblyAsync = ref.watch(
      singleAssemblyControllerProvider(assemblyId),
    );
    return Scaffold(
      appBar: AppBar(
        title: assemblyAsync.when(
          data: (data) => Text(LocaleKeys.qrCode.tr()),
          error: (error, stackTrace) => SizedBox.shrink(),
          loading: () => CircularProgressIndicator(),
        ),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 240,
              height: 240,
              child: assemblyJoinCodeAsync.when(
                data:
                    (data) => StandardContainer(
                      backgroundColor: Colors.green.withValues(alpha: .11),

                      child: Column(
                        children: [
                          assemblyAsync.when(
                            data: (assembly) {
                              return assembly != null
                                  ? Column(
                                    children: [
                                      Text(
                                        assembly.name,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                      ),
                                      Text(LocaleKeys.assembly.tr()),
                                    ],
                                  )
                                  : SizedBox.shrink();
                            },
                            error: (error, stackTrace) => SizedBox.shrink(),
                            loading: () => CircularProgressIndicator(),
                          ),
                          QrImageView(
                            size: 160,
                            data: data.joinCode,
                            eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.circle,
                              color: Colors.green,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              color: Colors.green,
                              dataModuleShape: QrDataModuleShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                error: (_, _) => SizedBox.shrink(),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
            ),
            const StandardSpace.vertical(),
            SizedBox(
              width: 240,
              child: Text(
                LocaleKeys.joinNotice.tr(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
