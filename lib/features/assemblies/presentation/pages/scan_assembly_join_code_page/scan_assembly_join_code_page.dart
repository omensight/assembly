import 'package:assembly/core/constants.dart';
import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assembly_join_request_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/join_assembly_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:uuid/uuid.dart';

class ScanAssemblyJoinCodePage extends HookConsumerWidget {
  const ScanAssemblyJoinCodePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblyJoinCode = useState<String?>(null);

    ref.listen(joinAssemblyControllerProvider, (previous, next) async {
      final assembly = next.valueOrNull;
      final joinCode = assemblyJoinCode.value;
      if (assembly != null && previous?.value == null && joinCode != null) {
        final state = await showModalBottomSheet(
          isScrollControlled: true,
          context: context,

          builder: (context) {
            return JoinAssemblyDialog(assembly: assembly, joinCode: joinCode);
          },
        );

        if (state == null || state == 0) {
          ref.read(joinAssemblyControllerProvider.notifier).resetValue();
          assemblyJoinCode.value = null;
        }
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (barcodes) {
              final result = barcodes.barcodes[0].rawValue;
              if (result != null) {
                try {
                  final code = UuidValue.raw(result);
                  if (assemblyJoinCode.value != code.uuid) {
                    assemblyJoinCode.value = code.uuid;
                    ref
                        .read(joinAssemblyControllerProvider.notifier)
                        .startJoinRequest(code.uuid);
                  }
                } catch (_) {}
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.5),
                BlendMode.srcOut,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      backgroundBlendMode: BlendMode.dstOut,
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 128),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.all(48),
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(width: 4, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              padding: const EdgeInsets.only(top: 112),
              child: Text(
                textAlign: TextAlign.center,
                LocaleKeys.scanAnAssemblyQrCodeToRequestToJoin.tr(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class JoinAssemblyDialog extends ConsumerWidget {
  const JoinAssemblyDialog({
    super.key,
    required this.assembly,
    required this.joinCode,
  });

  final Assembly assembly;
  final String joinCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(assemblyJoinRequestControllerProvider(assembly.id, joinCode), (
      previous,
      next,
    ) {
      next.when(
        data: (data) {
          if (data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.assemblyJoinRequestCreated.tr()),
              ),
            );
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.failureRequestingAssemblyJoin.tr()),
            ),
          );
        },
        loading: () {},
      );
    });
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.join_inner_rounded),
                      const StandardSpace.horizontal(),
                      Text(
                        LocaleKeys.joinAnAssembly.tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  StandardIconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      ref.context.pop(0);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: kStandardPadding,
                right: kStandardPadding,
                bottom: kStandardPadding,
              ),
              child: Column(
                children: [
                  StandardContainer(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assembly.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(assembly.address),
                      ],
                    ),
                  ),
                  const StandardSpace.vertical(),
                  SizedBox(
                    width: double.infinity,
                    child: StandardButton(
                      text: 'Request access',
                      isBackgroundColored: true,
                      onPressed: () {
                        ref
                            .read(
                              assemblyJoinRequestControllerProvider(
                                assembly.id,
                                joinCode,
                              ).notifier,
                            )
                            .requestAccess();
                        context.pop(0);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
