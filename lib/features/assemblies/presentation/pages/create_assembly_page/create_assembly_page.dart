import 'package:assembly/core/text_validators/common_text_validator.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_adaptable_width_container.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:assembly/features/assemblies/presentation/controllers/create_assembly_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateAssemblyPage extends HookConsumerWidget {
  const CreateAssemblyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(createAssemblyControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data != null) {
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
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final commonTextValidator = useMemoized(() => CommonTextValidator());
    final creationState = ref.watch(createAssemblyControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.createAssembly.tr()),
        actions: [
          creationState.isLoading
              ? CircularProgressIndicator()
              : StandardIconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  final isValid = formKey.currentState?.validate() ?? false;
                  if (isValid) {
                    ref
                        .read(createAssemblyControllerProvider.notifier)
                        .submitAssembly(
                          name: nameTextController.text,
                          address: addressTextController.text,
                        );
                  }
                },
              ),
        ],
      ),
      body: StandardAdaptableWidthContainer(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
