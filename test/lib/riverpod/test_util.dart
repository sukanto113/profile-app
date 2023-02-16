import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

class MockListener extends Mock{
  void call(prev, value);
}

ProviderContainer buildProviderContainerForTest({
  required void Function(void Function()) addTearDown,
  List<Override> overrides = const [],
}){
  final container = ProviderContainer(
    overrides: overrides
  );
  addTearDown(container.dispose);
  return container;
}