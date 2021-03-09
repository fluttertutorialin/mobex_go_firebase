import 'package:flutter/material.dart';

typedef DataWidgetBuilder<T> = Widget Function(BuildContext context, T data);
typedef DataErrorWidgetBuilder = Widget Function(
    BuildContext context, dynamic error);

class DataStreamBuilder<T> extends StreamBuilderBase<T, AsyncSnapshot<T>> {
  const DataStreamBuilder(
      {Key key,
      this.initialData,
      @required Stream<T> stream,
      @required this.builder,
      WidgetBuilder loadingBuilder,
      DataErrorWidgetBuilder errorBuilder})
      : assert(builder != null),
        this.loadingBuilder = loadingBuilder,
        this.errorBuilder = errorBuilder,
        super(key: key, stream: stream);

  /// The data that will be supplied to the builder in the first frame.
  final T initialData;

  /// The build strategy used by this builder to render the loading state.
  final WidgetBuilder loadingBuilder;

  /// The build strategy used by this builder to render the error state.
  final DataErrorWidgetBuilder errorBuilder;

  /// The build strategy used by this builder to render data.
  final DataWidgetBuilder<T> builder;

  @override
  AsyncSnapshot<T> initial() =>
      AsyncSnapshot<T>.withData(ConnectionState.none, initialData);

  @override
  AsyncSnapshot<T> afterConnected(current) =>
      current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<T> afterData(_, T data) =>
      AsyncSnapshot<T>.withData(ConnectionState.active, data);

  @override
  AsyncSnapshot<T> afterError(_, Object error) =>
      AsyncSnapshot<T>.withError(ConnectionState.active, error);

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) => current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) => current.inState(ConnectionState.none);

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> summary) {
    if (summary.hasError) return _getError(context, summary.error);
    if (summary.hasData) return builder(context, summary.data);
    return _getLoading(context);
  }

  Widget _getLoading(BuildContext context) {
    return loadingBuilder?.call(context) ??
        Center(child: CircularProgressIndicator());
  }

  Widget _getError(BuildContext context, dynamic error) {
    final _errorBuilder = errorBuilder ??
        (context, dynamic error) {
          error = error is Exception ? error.toString() : 'Error: $error';
          return Center(
              child: Text(
            error,
            textDirection: TextDirection.ltr,
            style: TextStyle(backgroundColor: Colors.red, color: Colors.white),
          ));
        };
    return _errorBuilder.call(context, error);
  }
}
