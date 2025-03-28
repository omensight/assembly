import 'package:assembly/core/constants.dart';
import 'package:assembly/core/extenstions/context_extensions.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fpdart/fpdart.dart';

class StandardTableWidget extends HookWidget {
  final List<String> headers;
  final List<StandardTableRow> rows;

  final bool shrinkWrap;
  final StandardTableState? forcedState;
  final Map<int, int> weights;
  const StandardTableWidget({
    super.key,
    required this.headers,
    required this.rows,
    this.shrinkWrap = false,
    this.forcedState,
    this.weights = const {},
  });

  @override
  Widget build(BuildContext context) {
    assert(() {
      final headersLength = headers.length;
      final s = rows
          .map((e) => e.children.length)
          .toList()
          .where((element) => element != headersLength);
      return s.isEmpty;
    }(), 'All the rows must have the same number of children as the headers');
    final isActionButtonVisible =
        rows.where((element) => element.rowOptionsButton != null).isNotEmpty;

    const headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    const contentTextStyle = TextStyle();
    final tableState =
        forcedState ??
        (context.isLargeWidthScreen()
            ? StandardTableState.table
            : StandardTableState.list);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: tableState == StandardTableState.table,
          child: Container(
            constraints: const BoxConstraints(minHeight: kMinItemHeight),
            padding: const EdgeInsets.all(kStandardPadding),
            child: DefaultTextStyle(
              style: headerTextStyle,
              child: Row(
                spacing: kStandardSpacing,
                children: [
                  ...headers.mapWithIndex(
                    (element, index) => Expanded(
                      flex: weights[index] ?? 1,
                      child: Text(element),
                    ),
                  ),
                  Visibility(
                    visible: isActionButtonVisible,
                    child: const StandardSpace.horizontal(space: 40),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (tableState == StandardTableState.list) StandardSpace.vertical(),
        Flexible(
          fit: shrinkWrap ? FlexFit.loose : FlexFit.tight,
          child: TableContentList(
            weights: weights,
            shrinkWrap: shrinkWrap,
            rows: rows,
            showAsList: tableState == StandardTableState.list,
            headers: headers,
            headerTextStyle: headerTextStyle,
            contentTextStyle: contentTextStyle,
          ),
        ),
      ],
    );
  }
}

class TableContentList extends StatelessWidget {
  const TableContentList({
    super.key,
    required this.shrinkWrap,
    required this.rows,
    required this.showAsList,
    required this.headers,
    required this.headerTextStyle,
    required this.contentTextStyle,
    required this.weights,
  });

  final bool shrinkWrap;
  final List<StandardTableRow> rows;
  final bool showAsList;
  final List<String> headers;
  final TextStyle headerTextStyle;
  final TextStyle contentTextStyle;
  final Map<int, int> weights;

  @override
  Widget build(BuildContext context) {
    final doesItemsContainOptionsButton =
        rows.where((element) => element.rowOptionsButton != null).isNotEmpty;
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      separatorBuilder: (context, index) => const StandardSpace.vertical(),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        final currentRow = rows[index];
        return showAsList
            ? Builder(
              builder: (context) {
                return Material(
                  color:
                      index % 2 == 0
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: .66),
                  borderRadius: BorderRadius.circular(kStandardBorderRadius),
                  child: InkWell(
                    onTap: currentRow.onItemTap,
                    borderRadius: BorderRadius.circular(kStandardBorderRadius),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          kStandardBorderRadius,
                        ),
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(kStandardPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ...headers
                              .mapWithIndex(
                                (t, index) => (t, currentRow.children[index]),
                              )
                              .map((tuple) {
                                return Row(
                                  spacing: kStandardSpacing,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${tuple.$1}:',
                                        style: headerTextStyle,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        tuple.$2,
                                        style: contentTextStyle,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : Material(
              color:
                  index % 2 == 0
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: .66),
              borderRadius: BorderRadius.circular(kStandardBorderRadius),
              child: InkWell(
                onTap: currentRow.onItemTap,
                borderRadius: BorderRadius.circular(kStandardBorderRadius),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(kStandardPadding),
                        constraints: const BoxConstraints(
                          minHeight: kMinItemHeight,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: kStandardSpacing,
                          children:
                              currentRow.children
                                  .mapWithIndex(
                                    (element, index) => Expanded(
                                      flex: weights[index] ?? 1,
                                      child: Text(
                                        element,
                                        style: contentTextStyle,
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        Widget optionsButton = const SizedBox.shrink();
                        if (currentRow.rowOptionsButton != null) {
                          optionsButton = currentRow.rowOptionsButton!;
                        } else {
                          if (doesItemsContainOptionsButton) {
                            optionsButton = const StandardIconButton(
                              icon: Icon(Icons.abc, color: Colors.transparent),
                            );
                          }
                        }
                        return optionsButton;
                      },
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}

class StandardTableRow {
  final List<String> children;
  final Widget? rowOptionsButton;
  final void Function()? onItemTap;
  StandardTableRow({
    required this.children,
    this.rowOptionsButton,
    this.onItemTap,
  });
}

enum StandardTableState { table, list }
