import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/values/providers.dart';

import '../../lib/riverpod/future_provider.dart';
import '../../lib/riverpod/test_util.dart';

@GenerateNiceMocks([MockSpec<IStudentRepository>()])
import 'student_list_provider_test.mocks.dart';

void main() {
  group('studentListProvider', () {
    late ProviderContainer container;
    late MockListener listener;
    late MockIStudentRepository studentRepository;
    setUp(() async {
      studentRepository = MockIStudentRepository();
      container = buildProviderContainerForTest(
        addTearDown: addTearDown,
        overrides: [
          studentRepositoryProvider.overrideWithValue(studentRepository),
        ]
      );
      listener = MockListener();
    });
    
    test('watch StudentListNotifire', () async {
      await verifyFutureProviderWatchingOn(
        container: container,
        provider: studentsListProvider,
        onUpdate: () {
         container.read(studentsListNotifireProvider.notifier).updateState();  
        }
      );
    });

    test('return students from repo', () async {
      when(studentRepository.readAll()).thenAnswer((_) async =>[
        Student(id: 1, name: "John Doe", roll: "101"),
      ]);

      container.listen(studentsListProvider, listener, fireImmediately: true);
      await awaitToCompleteProviderFuture(container, studentsListProvider);
      
      verifyInitialAsyncLoadingCall(listener);
      verifyAsyncDataCallHavingValue(listener, equals([
        Student(id: 1, name: "John Doe", roll: "101"),
      ]));
      verifyNoMoreInteractions(listener);
    });

    test('call readAll once', () async {
      container.listen(studentsListProvider, listener, fireImmediately: true);
      await awaitToCompleteProviderFuture(container, studentsListProvider);

      verify(studentRepository.readAll()).called(1);
      verifyNoMoreInteractions(studentRepository);
    });
  });
}