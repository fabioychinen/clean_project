import 'package:bloc_test/bloc_test.dart';
import 'package:clean_project/application/pages/advicer/cubit/advicer_cubit.dart';
import 'package:clean_project/domain/entities/advice_entity.dart';
import 'package:clean_project/domain/failures/failures.dart';
import 'package:clean_project/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';

class MockAdviceUseCases extends Mock implements AdvicerUseCases {}

void main() {
  group('AdvicerCubit', () {
    group(
      'should emit',
      () {
        MockAdviceUseCases mockAdvicerUseCases = MockAdviceUseCases();

        blocTest(
          'nothing when no method is called',
          build: () => AdvicerCubit(adviceUseCases: mockAdvicerUseCases),
          expect: () => const <AdvicerCubitState>[],
        );

        blocTest(
          '[AdvicerStateLoading, AdvicerStateLoaded] when adviceRequested() is called',
          setUp: () => when(() => mockAdvicerUseCases.getAdvice()).thenAnswer(
            (invocation) => Future.value(
              const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'advice', id: 1),
              ),
            ),
          ),
          build: () => AdvicerCubit(adviceUseCases: mockAdvicerUseCases),
          act: (cubit) => cubit.adviceRequested(),
          expect: () => const <AdvicerCubitState>[
            AdvicerStateLoading(),
            AdvicerStateLoaded(advice: 'advice')
          ],
        );

        group(
          '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
          () {
            blocTest(
              'and a ServerFailure occors',
              setUp: () =>
                  when(() => mockAdvicerUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    ServerFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUseCases: mockAdvicerUseCases),
              act: (cubit) => cubit.adviceRequested(),
              expect: () => const <AdvicerCubitState>[
                AdvicerStateLoading(),
                AdvicerStateError(message: serverFailureMessage),
              ],
            );

            blocTest(
              'and a CacheFailure occors',
              setUp: () =>
                  when(() => mockAdvicerUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    CacheFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUseCases: mockAdvicerUseCases),
              act: (cubit) => cubit.adviceRequested(),
              expect: () => const <AdvicerCubitState>[
                AdvicerStateLoading(),
                AdvicerStateError(message: cacheFailureMessage),
              ],
            );

            blocTest(
              'and a GeneralFailure occors',
              setUp: () =>
                  when(() => mockAdvicerUseCases.getAdvice()).thenAnswer(
                (invocation) => Future.value(
                  Left<Failure, AdviceEntity>(
                    GeneralFailure(),
                  ),
                ),
              ),
              build: () => AdvicerCubit(adviceUseCases: mockAdvicerUseCases),
              act: (cubit) => cubit.adviceRequested(),
              expect: () => const <AdvicerCubitState>[
                AdvicerStateLoading(),
                AdvicerStateError(message: generalFailureMessage),
              ],
            );
          },
        );
      },
    );
  });
}
