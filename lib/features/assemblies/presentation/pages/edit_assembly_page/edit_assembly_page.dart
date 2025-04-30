import 'package:assembly/core/text_validators/common_text_validator.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_adaptable_width_container.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/core/widgets/standard_switch.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:assembly/features/assemblies/presentation/controllers/single_assembly_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/update_assembly_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditAssemblyPage extends HookConsumerWidget {
  final String assemblyId;

  const EditAssemblyPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblyAsync = ref.watch(
      singleAssemblyControllerProvider(assemblyId),
    );

    ref.listen(updateAssemblyControllerProvider(assemblyId), (previous, next) {
      next.when(
        data: (data) {
          if (data != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.assemblyUpdatedSuccessfully.tr()),
              ),
            );
            context.pop();
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error as String)));
        },
        loading: () {},
      );
    });

    final nameTextController = useTextEditingController();
    final addressTextController = useTextEditingController();
    final isActive = useState<bool>(true);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final commonTextValidator = useMemoized(() => CommonTextValidator());
    final updateState = ref.watch(updateAssemblyControllerProvider(assemblyId));

    useEffect(() {
      assemblyAsync.whenData((assembly) {
        if (assembly != null) {
          nameTextController.text = assembly.name;
          addressTextController.text = assembly.address;
          isActive.value = assembly.isActive;
        }
      });
      return null;
    }, [assemblyAsync]);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.editAssembly.tr()),
        actions: [
          updateState.isLoading
              ? const CircularProgressIndicator()
              : StandardIconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  final isValid = formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    ref
                        .read(
                          updateAssemblyControllerProvider(assemblyId).notifier,
                        )
                        .updateAssembly(
                          name:
                              nameTextController.text.isEmpty
                                  ? null
                                  : nameTextController.text,
                          address:
                              addressTextController.text.isEmpty
                                  ? null
                                  : addressTextController.text,
                          isActive: isActive.value,
                        );
                  }
                },
              ),
        ],
      ),
      body: assemblyAsync.when(
        data: (assembly) {
          if (assembly == null) {
            return Center(child: Text(LocaleKeys.assemblyNotFound.tr()));
          }

          final isAssemblyActiveStateNotifier = useState<bool>(
            assembly.isActive,
          );

          return StandardAdaptableWidthContainer(
            child: Padding(
              padding: standardPadding,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    StandardTextFormField(
                      controller: nameTextController,
                      label: LocaleKeys.assemblyName.tr(),
                      validator:
                          (value) => commonTextValidator.requiredField(value),
                    ),
                    const StandardSpace.vertical(),
                    StandardTextFormField(
                      controller: addressTextController,
                      label: LocaleKeys.address.tr(),
                    ),
                    const StandardSpace.vertical(),
                    StandardSwitch(
                      title: LocaleKeys.isActive.tr(),
                      description: LocaleKeys.isActiveDescription.tr(),
                      switchStateNotifier: isAssemblyActiveStateNotifier,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) => Center(
              child: Text('${LocaleKeys.failureLoadingAssembly.tr()}: $error'),
            ),
      ),
    );
  }
}
