import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseView<T extends Bloc> extends StatefulWidget {
  const BaseView({super.key});

  T createViewModel();

  Widget buildView(BuildContext context);

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Bloc> extends State<BaseView<T>> {
  late T viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.createViewModel();
  }

  @override
  void dispose() {
    viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(create: (context) => viewModel, child: widget.buildView(context));
  }
}
