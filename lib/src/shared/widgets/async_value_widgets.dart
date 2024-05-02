import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) data;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: data,
      // TODO: replace with custom error widget
      error: (e, st) => Center(
        child: Text(e.toString()),
      ),
      // TODO: replace with custom loading widget
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class ScaffoldAsyncValueWidget<T> extends StatelessWidget {
  const ScaffoldAsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.data,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) data;

  @override
  Widget build(BuildContext context) {
    // TODO: replace with custom scaffold
    return asyncValue.when(
      data: data,
      error: (e, st) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(e.toString()),
        ),
      ),
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
