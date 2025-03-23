import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class StandardFormTimePicker extends HookWidget {
  final ValueNotifier<int?> hourValueNotifier;
  final ValueNotifier<int?> minuteValueNotifier;
  final String? label;
  const StandardFormTimePicker({
    super.key,
    required this.hourValueNotifier,
    required this.minuteValueNotifier,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final time = useState<TimeOfDay?>(null);
    final hour = useValueListenable(hourValueNotifier);
    final minute = useValueListenable(minuteValueNotifier);
    useEffect(() {
      if (hour != null && minute != null) {
        time.value = TimeOfDay(hour: hour, minute: minute);
      } else {
        time.value = null;
      }
      return;
    }, [hour, minute]);
    String? formattedTime = time.value?.format(context);
    final timeTextController = useTextEditingController(text: formattedTime);
    useEffect(() {
      void onChange() {
        timeTextController.text =
            formattedTime ?? LocaleKeys.noPreferredTimeSelected.tr();
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => onChange());
      return;
    }, [formattedTime]);
    return StandardTextFormField(
      controller: timeTextController,
      label: label ?? '',
      editState: EditState.readOnly,
      suffixIcon: Icon(Icons.access_time),
      onTap: () async {
        final selectedTimeOfDay = await showTimePicker(
          context: context,
          initialTime: time.value ?? TimeOfDay.now(),
        );
        hourValueNotifier.value = selectedTimeOfDay?.hour;
        minuteValueNotifier.value = selectedTimeOfDay?.minute;
      },
      validator: (_) {
        final hour = hourValueNotifier.value;
        final minute = minuteValueNotifier.value;
        if (hour == null && minute == null) {
          return LocaleKeys.noPreferredTimeSelected.tr();
        }
        return null;
      },
    );
  }
}
