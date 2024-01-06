import 'package:fetchapi/apimodel/model_data.dart';
import 'package:fetchapi/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The above class is an abstract class called PostState that is immutable.
@immutable
abstract class PostState {}

/// The above class defines different states for a post, including initial state, loading state, loaded
/// state with a list of posts, and error state with an error message.
class InitialState extends PostState {}

class LodingState extends PostState {}

class LoadedState extends PostState {
  final List<ApiModel> posts;

  LoadedState({required this.posts});
}

class ErrorState extends PostState {
  final String error;

  ErrorState({required this.error});
}

/// The `PostNotifier` class is a state notifier that fetches posts from an API service and updates the
/// state accordingly.
class PostNotifier extends StateNotifier<PostState> {
  PostNotifier({required this.apiservice}) : super(InitialState());
  final ApiService apiservice;

  /// The function fetchPost() fetches posts from an API and updates the state accordingly.
  fetchPost() async {
    try {
      state = LodingState();
      List<ApiModel> posts = await apiservice.getPost();
      state = LoadedState(posts: posts);
    } catch (e) {
      state = ErrorState(error: e.toString());
    }
  }
}
