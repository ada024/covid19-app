import 'package:covid19_app/features/covid19_status/domain/entities/cov.dart';
import 'package:covid19_app/features/covid19_status/domain/repositories/cov_repository.dart';
import 'package:covid19_app/features/covid19_status/domain/usecases/get_country_status_.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockCov19AppRepository extends Mock implements CovRepository {}

void main() {
  GetCountryStatus  useCase;
  MockCov19AppRepository mockCov19AppRepository;

  setUp(() {
    mockCov19AppRepository = MockCov19AppRepository();
    useCase = GetCountryStatus(mockCov19AppRepository);
  });

  const tCountry = "USA";
  final tCovStatus = CovStatus(active: "4245",confirmed: "312",deaths: "12",recovered: "200");

  test(
    'should get cov-status from the repository',
        () async {
      // arrange
      when(mockCov19AppRepository.getCountryStatus(any))
          .thenAnswer((_) async => Right(tCovStatus));
      // act
      final res = await useCase(Params(country: "USA"));
      // assert
      expect(res, Right());
      verify(mockCov19AppRepository.getCountryStatus(tCountry));
      verifyNoMoreInteractions(mockCov19AppRepository);
    },
  );
}
