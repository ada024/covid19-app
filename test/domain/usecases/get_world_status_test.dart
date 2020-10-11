import 'package:covid19_app/core/usecases/usecase.dart';
import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:covid19_app/features/covid19_status/domain/repositories/cov_repository.dart';
import 'package:covid19_app/features/covid19_status/domain/usecases/get_world_status.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCov19AppRepository extends Mock
    implements CovRepository {}

void main() {
  GetWorldStatus usecase;
  MockCov19AppRepository mockCov19AppRepository;

  setUp(() {
    mockCov19AppRepository = MockCov19AppRepository();
    usecase = GetWorldStatus(mockCov19AppRepository);
  });


  final tCovStatus = CovStatus(active: "320",confirmed: "150",deaths: "7",recovered: "180");

  test(
    'should get status from the repository',
        () async {
      // arrange
      when(mockCov19AppRepository.getWorldStatus())
          .thenAnswer((_) async => Right(tCovStatus));
      // act
      final res = await usecase(NoParams());
      // assert
      expect(res, Right( tCovStatus));
      verify(mockCov19AppRepository.getWorldStatus());
      verifyNoMoreInteractions(mockCov19AppRepository);
    },
  );
}
