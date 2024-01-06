import 'package:fetchapi/provider/api_provider.dart';
import 'package:fetchapi/provider/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Api call demo'),
          centerTitle: true,
          elevation: 1,
        ),
        body: Consumer(builder: (context, ref, child) {
          /// The line `final state = ref.watch(stateProvider);` is using the `watch` method from the
          /// `ref` object to listen to changes in the state provided by the `stateProvider`. It retrieves
          /// the current state value and assigns it to the `state` variable. This allows the widget to
          /// reactively rebuild whenever the state changes.
          final state = ref.watch(stateProvider);

          /// The code block is handling different states of the API call.
          if (state is InitialState) {
            return const Center(
                child: Text(
              'Press button to fetch data',
              style: TextStyle(fontSize: 18),
            ));
          }
          if (state is LodingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state == ErrorState) {
            // debugPrint(state.error);

            return _showToast(state.error);
          }
          if (state is LoadedState) {
            return _buildLiastView(state, context);
          }
          return const Text('No data');
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /// `ref.read(stateProvider.notifier).fetchPost();` is calling the `fetchPost()` method from
            /// the `notifier` object associated with the `stateProvider`.
            ref.read(stateProvider.notifier).fetchPost();
          },
          child: const Center(
              child: Icon(
            Icons.add,
            size: 18,
          )),
        ),
      ),
    );
  }

  Widget _buildLiastView(LoadedState state, BuildContext context) {
    return ListView.builder(
        itemCount: state.posts.length,
        itemBuilder: (context, index) {
          var post = state.posts[index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.3)),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(post.id.toString()),
                ),
                title: Text(
                  state.posts[index].title,
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(post.description),
                contentPadding: const EdgeInsets.all(4),
              ),
            ),
          );
        });
  }

  _showToast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
