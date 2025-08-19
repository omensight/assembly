Feature structure:

# feature Project Structure
This project is structured that you must use for every feature into three main layers: data, domain, and presentation. Each layer has its own responsibilities and contains specific components that interact with each other to form a complete application.
lib
├── core // core 
└── features 
    └── feature_zero // feature 0
        ├── data // data layer
        │   ├── data_sources // Contains data sources that interact with external APIs or databases.
        │   │   ├── data_source_impl.dart // A data source that implements the data source interface contained in the domain layer.
        │   │   ├── assembly_join_request_remote_data_source_impl.g.dart // Generated file for assembly join request data source.
        │   ├── models // Data models that represent the data structure used in the application.
        │   │   ├── model_0.dart
        │   │   ├── model_0.g.dart
        │   │   ├── model_1.dart
        │   │   └── model_1.g.dart
        │   └── repositories // Contains repository implementations that interact with data sources.ad
        │       ├── repository_zero_impl.dart // Implementation of the assignment repository interface present in the domain layer.
        │       └── repository_one_impl.dart
        │       └── repository_two_impl.dart
        ├── domain // domain layer
        │   ├── entities // Contains the core entities of the application.
        │   │   ├── assignment_group.dart
        │   │   ├── assignment_group.g.dart
        │   │   ├── assignment_settings.dart
        │   │   └── assignment_settings.g.dart
        │   ├── repositories // Contains repository interfaces that define the contract for data access.
        │   │   ├── repository_0.dart
        │   │   ├── repository_1.dart
        │   │   └── repository_2.dart
        │   └── usecases // Contains use cases that encapsulate the business logic of the application separated by functionality.
        │       ├── functionality_0
        │       │   ├── get_model_zero_list_usecase.dart
        │       │   ├── update_model_zero_usecase.dart
        │       │   └── delete_model_zero_usecase.dart
        │       └── functionality_1
        │           ├── get_model_one_list_usecase.dart
        │           ├── update_model_two_usecase.dart
        │           └── delete_model_3_usecase.dart
        ├── presentation // presentation layer
        │   ├── controllers // Contains controllers that manage the state and logic of the UI separated by functionality.
        │   │   ├── functionality_0
        │   │   │   ├── retrieve_model_zero_controller.dart
        │   │   │   ├── retrieve_model_zero_controller.g.dart
        │   │   │   ├── create_model_one_controller.dart
        │   │   │   ├── create_model_one_controller.g.dart
        │   │   │   ├── list_something_controller.dart
        │   │   │   └── list_something_controller.g.dart
        │   │   └── functionality_1
        │   │       ├── delete_model_zero_controller.dart
        │   │       ├── delete_model_zero_controller.g.dart
        │   │       ├── create_model_one_controller.dart
        │   │       ├── create_model_one_controller.g.dart
        │   │       ├── delete_model_two_controller.dart
        │   │       └── delete_model_two_controller.g.dart
        │   ├── pages // Contains the UI pages of the application separated by pages.
        │   │   ├── show_something_zero
        │   │   │   ├── widgets
        │   │   │   │   ├── widget_zero.dart
        │   │   │   │   └── widget_one.dart
        │   │   │   └── show_something_zero_page.dart
        │   │   ├── show_something_one
        │   │   │   ├── widgets
        │   │   │   │   ├── widget_zero.dart
        │   │   │   │   └── widget_one.dart
        │   │   │   └── show_something_zero_page.dart
        │   │   └── show_something_two
        │   │       ├── widgets
        │   │       │   ├── widget_zero.dart
        │   │       │   ├── widget_one.dart
        │   │       │   ├── widget_two.dart
        │   │       │   └── widget_three.dart
        │   │       └── show_something_zero_page.dart
        │   └── providers
        │       ├── data_source_providers.dart
        │       ├── data_source_providers.g.dart
        │       ├── repository_providers.dart
        │       ├── repository_providers.g.dart
        │       ├── usecase_providers.dart
        │       └── usecase_providers.g.dart
        ├── routes.dart
        └── routes.g.dart

# Usecases 
Use cases are the core of the domain layer, encapsulating the business logic of the application. Each use case should be defined in its own file and should be named according to the functionality it provides. Use cases should interact with repositories to perform operations and return results.
Use cases should be organized into directories based on their functionality, and each directory should contain the relevant use cases for that functionality. For example, if you have a functionality related to managing assignments, you might have a directory named `assemblies` that contains use cases like `get_assemblies_usecase.dart`, `update_assembly_join_request_usecase.dart`, and `delete_assembly_join_request_usecase.dart`.

Every usecase must be follow the naming convention of `get_model_zero_list_usecase.dart`, `update_model_zero_usecase.dart`, and `delete_model_zero_usecase.dart`. This helps in maintaining consistency and clarity in the codebase.

Every usecase must be implemented as a class that extends the `UseCase` class from the `core` package. The class should have a method named `call` that takes the necessary parameters and returns the result. The `UseCase` class should be defined in the `core` package and should provide a base implementation for all use cases.
e.g.
```dart
class GetAssemblyJoinRequestsUsecase
    implements
        Usecase<List<AssemblyJoinRequest>, GetAssemblyJoinRequestsParams> {
  final AssemblyJoinRequestRepository _assemblyJoinRequestRepository;

  GetAssemblyJoinRequestsUsecase({
    required AssemblyJoinRequestRepository assemblyJoinRequestRepository,
  }) : _assemblyJoinRequestRepository = assemblyJoinRequestRepository;

  @override
  TaskEither<GetAssemblyJoinRequestsFailure, List<AssemblyJoinRequest>> build(
    GetAssemblyJoinRequestsParams params,
  ) {
    return TaskEither.tryCatch(
      () => _assemblyJoinRequestRepository.getAssemblyJoinRequests(
        params.assemblyId,
      ),
      (error, stackTrace) => NetworkFailure(),
    );
  }
}

class GetAssemblyJoinRequestsParams extends Params {
  final String assemblyId;

  GetAssemblyJoinRequestsParams({required this.assemblyId});
}

sealed class GetAssemblyJoinRequestsFailure extends Failure {}

class NetworkFailure extends GetAssemblyJoinRequestsFailure {}

```
The previous useacase is an example of how to implement a use case in the domain layer. It defines a use case for getting assembly join requests, implements the `UseCase` interface, and provides a method to execute the use case logic.

The Usecase interface is located at /lib/core/usecase.dart and should be implemented by all use cases in the domain layer. It provides a base structure for use cases, allowing them to be executed with specific parameters and return results.