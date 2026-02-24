# GitHub Copilot Instructions – Flutter MVVM Clean Architecture

You are assisting in a Flutter project that strictly follows MVVM with Clean Architecture.

You MUST follow these instructions when generating any code.

---

# Architecture Overview

The project uses 4 layers:

1. Presentation Layer
2. Domain Layer
3. Data Layer
4. Core Layer

Dependency direction:

Presentation → Domain → Data → Core

Never reverse dependencies.

---

# Folder Structure

All features must follow this structure:

lib/features/<feature_name>/

data/

- models/
- datasources/
- repositories_impl/

domain/

- entities/
- repositories/
- usecases/

presentation/

- bloc/
- pages/
- widgets/

core/

- constants/
- utils/validators/
- network/
- theme/
- presendtaion/widgets/

---

# Strict Layer Rules

## Domain Layer

Contains:

- Entities
- Repository interfaces
- UseCases

Rules:

- No Flutter imports
- No JSON
- No external libraries
- Pure Dart only

Entity example:

```dart
class UserEntity {
  final int id;
  final String name;
  final String email;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

## Data Layer

Contains:

- Models
- Repository implementations
- Remote data sources
- Local data sources

Model rules:

- Extends Entity
- Handles JSON conversion

Example:```
class UserModel extends UserEntity {

UserModel({
required super.id,
required super.name,
required super.email,
});

factory UserModel.fromJson(Map<String, dynamic> json) {
return UserModel(
id: json['id'],
name: json['name'],
email: json['email'],
);
}
}

````
Repository implementation rules:

- Implements repository interface from domain layer
- Returns Entity, not Model

## Domain UseCase Rules

UseCase must always have call() method.

Example:```
class LoginUseCase {

  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.login(email, password);
  }
}
````

## Presentation Layer

Contains:

- ViewModels
- Screens
- Widgets

ViewModel rules:

- Calls UseCases only
- Never calls API directly
- Never accesses SharedPreferences directly
- Handles UI state

Example:```
class LoginViewModel extends ChangeNotifier {

final LoginUseCase loginUseCase;

LoginViewModel(this.loginUseCase);

bool isLoading = false;

Future<void> login(String email, String password) async {

    isLoading = true;
    notifyListeners();

    await loginUseCase(email, password);

    isLoading = false;
    notifyListeners();

}
}

````

JSON Conversion Flow

Always follow this flow:

JSON → Model → Entity → ViewModel → UI

Never pass Model directly to UI.

## SharedPreferences Rules

SharedPreferences must be accessed ONLY in:

data/datasources/local/

Never access SharedPreferences in:

- ViewModel
- UseCase
- UI

## Naming Conventions

Files:

snake_case.dart

Examples:

user_entity.dart
user_model.dart
login_usecase.dart
login_viewmodel.dart

Classes:

PascalCase

Examples:

UserEntity
UserModel
LoginUseCase
LoginViewModel

## Repository Pattern Rules

Repository interface location:

domain/repositories/

Repository implementation location:

data/repositories/

Naming:

UserRepository
UserRepositoryImpl

## Dependency Injection Rules

Dependencies must be injected.

Example:```
final repository = UserRepositoryImpl(remoteDataSource);
final useCase = LoginUseCase(repository);
final viewModel = LoginViewModel(useCase);
````

Never create dependencies inside ViewModel.

## Widget Rules

Reusable widgets must go in:

core/widgets/

Feature-specific widgets must go in:

features/<feature>/presentation/widgets/

## Validation Rules

Validators must go in:

core/validators/

## What Copilot MUST DO

### Copilot MUST:

- Follow MVVM Clean Architecture
- Use UseCase between ViewModel and Repository
- Use Entity in Domain layer
- Use Model in Data layer
- Place files in correct folders
- Use correct naming conventions
- Use dependency injection
- Separate layers strictly
- use flutter SDK version 3.9.0

### Copilot MUST NOT:

- Call API from ViewModel
- Use Model in UI
- Skip UseCase layer
- Mix Model and Entity
- Access SharedPreferences outside Data layer
- When generating new features
- dont use depricated code write a code for Flutter SDK version 3.9.0

## Copilot MUST generate:

Entity
Model
Repository Interface
Repository Implementation
UseCase
ViewModel
Pages

in correct folders.

END OF INSTRUCTIONS
