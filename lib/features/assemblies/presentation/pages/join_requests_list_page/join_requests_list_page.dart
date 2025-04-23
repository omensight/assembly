import 'package:assembly/core/constants.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/presentation/controllers/accept_join_request_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assembly_join_requests_list_controller.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class JoinRequestsListPage extends ConsumerWidget {
  final String assemblyId;

  const JoinRequestsListPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final joinRequestsAsync = ref.watch(
      assemblyJoinRequestsListControllerProvider(assemblyId),
    );

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.joinRequests.tr())),
      body: Padding(
        padding: standardHorizontalPadding,
        child: joinRequestsAsync.when(
          data:
              (joinRequests) =>
                  joinRequests.isEmpty
                      ? Center(
                        child: StandardEmptyView(
                          imagePath:
                              'assets/empty_views/im_ev_no_assembly_join_requests.webp',
                          message: LocaleKeys.noJoinRequestsFound.tr(),
                        ),
                      )
                      : ListView.separated(
                        separatorBuilder:
                            (context, index) => const StandardSpace.vertical(),
                        itemCount: joinRequests.length,
                        itemBuilder: (context, index) {
                          final joinRequest = joinRequests[index];
                          return StandardContainer(
                            forceBorderDrawing: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      joinRequest.user.fullName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(joinRequest.user.username),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  spacing: kStandardSpacing,
                                  children: [
                                    StandardIconButton(
                                      isFilled: true,
                                      icon: Icon(Icons.close),
                                      isError: true,
                                      onPressed: () {
                                        //TODO: Implement reject request functionality
                                        throw UnimplementedError(
                                          'Reject request functionality not implemented yet',
                                        );
                                      },
                                    ),
                                    AcceptsJoinRequestButton(
                                      assemblyId: assemblyId,
                                      joinRequest: joinRequest,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) => Center(
                child: Text(
                  '${LocaleKeys.failureLoadingJoinRequests.tr()}: $error',
                ),
              ),
        ),
      ),
    );
  }
}

class AcceptsJoinRequestButton extends ConsumerWidget {
  const AcceptsJoinRequestButton({
    super.key,
    required this.assemblyId,
    required this.joinRequest,
  });

  final String assemblyId;
  final AssemblyJoinRequest joinRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final acceptanceAsyncState = ref.watch(
      acceptJoinRequestControllerProvider(assemblyId, joinRequest.id),
    );
    return acceptanceAsyncState.isLoading
        ? const CircularProgressIndicator()
        : StandardIconButton(
          isFilled: true,
          icon: Icon(Icons.check),
          onPressed: () {
            ref
                .read(
                  AcceptJoinRequestControllerProvider(
                    assemblyId,
                    joinRequest.id,
                  ).notifier,
                )
                .acceptRequest();
          },
        );
  }
}
