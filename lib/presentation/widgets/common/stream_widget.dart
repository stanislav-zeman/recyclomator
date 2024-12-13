import 'package:flutter/material.dart';

class StreamWidget<T> extends StatelessWidget {
  const StreamWidget({
    super.key,
    required this.stream,
    required this.onData,
  });

  final Stream<T> stream;
  final Widget Function(T) onData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('An error occurred!'),
          );
        }

        // ignore: null_check_on_nullable_type_parameter
        return onData(snapshot.data!);
      },
    );
  }
}
