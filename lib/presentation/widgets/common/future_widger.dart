import 'package:flutter/material.dart';

class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T) onData;

  const FutureWidget({
    super.key,
    required this.future,
    required this.onData,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("An error occured!"),
          );
        }

        // ignore: null_check_on_nullable_type_parameter
        return onData(snapshot.data!);
      },
    );
  }
}
