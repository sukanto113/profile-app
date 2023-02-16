import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/mockito.dart';

import 'test_util.dart';

void verifyAsyncLoadingCall(MockListener listener) {
  verify(listener(isA<AsyncData>(), isA<AsyncLoading>())).called(1);
}

void verifyAsyncDataCall(MockListener listener) {
  verify(listener(isA<AsyncLoading>(), isA<AsyncData>())).called(1);
}

void verifyInitialAsyncLoadingCall(MockListener listener) {
  verify(listener(null, isA<AsyncLoading>())).called(1);
}

Future<void> verifyFutureProviderWatchingOn({
  required ProviderContainer container,
  required FutureProvider provider, 
  required void Function() onUpdate
}) async {
  final listener = MockListener();
  container.listen(provider, listener, fireImmediately: true);
  await awaitToCompleteProviderFuture(container, provider);
  
  verifyInitialAsyncLoadingAndDataCall(listener);  
  onUpdate();
  await awaitToCompleteProviderFuture(container, provider);
  verifyAsyncLoadingAndADataCall(listener);
}

Future<void> awaitToCompleteProviderFuture(
  ProviderContainer container,
  FutureProvider<dynamic> provider
) async {
  await container.read(provider.future);
}

void verifyInitialAsyncLoadingAndDataCall(MockListener listener) {
  verifyInOrder([
    listener(null, isA<AsyncLoading>()),
    listener(isA<AsyncLoading>(), isA<AsyncData>())
  ]);
  verifyNoMoreInteractions(listener);
}

void verifyAsyncLoadingAndADataCall(MockListener listener) {
  verifyInOrder([
    listener(isA<AsyncData>(), isA<AsyncLoading>()),
    listener(isA<AsyncLoading>(), isA<AsyncData>()),
  ]);
  verifyNoMoreInteractions(listener);
}

void verifyAsyncDataCallHavingValue(MockListener listener, Matcher matcher) {
  verify(listener(isA<AsyncLoading>(), isA<AsyncData>().having(
    (data) => data.value, "value", matcher
  ))).called(1);
}