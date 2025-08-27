import 'package:digital_episode/core/network/dio_client.dart';
import 'package:digital_episode/data/repositories/home_repository.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

/// Dependency Injection kurulumu
/// Uygulama başlangıcında çağrılır ve tüm servisleri kaydeder
Future<void> setupDependencyInjection() async {
  // Network Layer
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Repositories
  getIt.registerLazySingleton<HomeRepositoryInterface>(
    () => HomeRepository(getIt<DioClient>()),
  );

  // Cubit'ler genellikle BlocProvider ile oluşturulur, bu yüzden burada kaydetmiyoruz
  // Eğer global bir cubit kullanacaksanız burada kaydedebilirsiniz
}