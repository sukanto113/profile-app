import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HookConsumerWidgetBuildInfo {

  final BuildContext context;
  final WidgetRef ref;
  final IsMounted isMounted;

  const HookConsumerWidgetBuildInfo({
    required this.context,
    required this.ref,
    required this.isMounted
  });
}


class FormBuildInfo extends HookConsumerWidgetBuildInfo {

  final GlobalKey<FormState> formKey;

  FormBuildInfo({
    required super.context,
    required super.ref,
    required super.isMounted,
    required this.formKey,
  });
}