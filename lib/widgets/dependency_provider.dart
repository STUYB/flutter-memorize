import 'package:flutter/cupertino.dart';
import 'package:memorize/bloc/bloc_provider.dart';
import 'package:memorize/data/repository_provider.dart';

class DependencyProvider extends StatelessWidget {
  final Widget child;
  const DependencyProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return RepoProvider(
        child: MemorizeBlocProvider(
      child: child,
    ));
  }
}
