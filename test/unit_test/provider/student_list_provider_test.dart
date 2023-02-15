import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:profile_app/db/students_database.dart';
import 'package:profile_app/model/student.dart';
import 'package:profile_app/values/providers.dart';

@GenerateNiceMocks([MockSpec<IStudentRepository>()])
import 'student_list_provider_test.mocks.dart';

class Listener extends Mock{
  void call(prev, value);
}

void main() {
  group('studentListProvider', () {
    late ProviderContainer container;
    late Listener listener;
    late MockIStudentRepository studentRepository;
    setUp(() async {
      studentRepository = MockIStudentRepository();
      container = ProviderContainer(
        overrides: [
          studentRepositoryProvider.overrideWithValue(studentRepository),
        ]
      );
      addTearDown(container.dispose);
      listener = Listener();
    });
    
    test('watch StudentListNotifire', () async {
      container.listen(studentsListProvider, listener, fireImmediately: true);
      await container.read(studentsListProvider.future);

      verify(listener(null, isA<AsyncLoading>())).called(1);
      verify(listener(isA<AsyncLoading>(), isA<AsyncData>())).called(1);
      verifyNoMoreInteractions(listener);

      container.read(studentsListNotifireProvider.notifier).updateState();
      await container.read(studentsListProvider.future);

      verify(listener(isA<AsyncData>(), isA<AsyncLoading>())).called(1);
      verify(listener(isA<AsyncLoading>(), isA<AsyncData>())).called(1);
      verifyNoMoreInteractions(listener);
    });

    test('return students from repo', () async {
      when(studentRepository.readAll()).thenAnswer((_) async =>[
        Student(id: 1, name: "John Doe", roll: "101"),
      ]);

      container.listen(studentsListProvider, listener, fireImmediately: true);
      await container.read(studentsListProvider.future);
      
      verify(listener(null, isA<AsyncLoading>())).called(1);
      verify(listener(isA<AsyncLoading>(), isA<AsyncData>().having(
        (data) => data.value, "value", equals([
          Student(id: 1, name: "John Doe", roll: "101"),
        ])
      ))).called(1);
      verifyNoMoreInteractions(listener);
    });

    test('call readAll once', () async {
      container.listen(studentsListProvider, listener, fireImmediately: true);
      await container.read(studentsListProvider.future);

      verify(studentRepository.readAll()).called(1);
      verifyNoMoreInteractions(studentRepository);
    });
  });
}