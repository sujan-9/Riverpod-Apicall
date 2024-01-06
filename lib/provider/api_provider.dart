import 'package:fetchapi/provider/post_state.dart';
import 'package:fetchapi/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `final apiServiceProvider = Provider((ref) => ApiService());` is creating a provider called
/// `apiServiceProvider` that provides an instance of the `ApiService` class.
/// This provider can be used to obtain an instance of `ApiService` anywhere in the application where it
/// is needed.
final apiServiceProvider = Provider((ref) => ApiService());

/// `final stateProvider` is creating a provider called `stateProvider` that provides an instance of
/// `PostNotifier` class. The `StateNotifierProvider` constructor takes two type parameters:
/// `PostNotifier` and `PostState`.
final stateProvider = StateNotifierProvider<PostNotifier, PostState>(
    (ref) => PostNotifier(apiservice: ref.watch(apiServiceProvider)));
