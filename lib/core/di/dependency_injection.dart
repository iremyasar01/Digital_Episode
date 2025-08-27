
import 'package:digital_episode/core/network/dio_client.dart';
import 'package:digital_episode/data/repositories/home_repository.dart';
import 'package:digital_episode/domain/repositories/home_repository_interface.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

/// Dependency Injection Setup
/// Tüm servisleri ve repository'leri burada kayıt ediyoruz
class DependencyInjection {
  static Future<void> init() async {
    // Network Layer
    getIt.registerLazySingleton<DioClient>(() => DioClient());

    // Repositories
    getIt.registerLazySingleton<HomeRepositoryInterface>(
      () => HomeRepository(getIt<DioClient>()),
    );
  }
}

// main.dart içinde kullanım:
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DependencyInjection.init();
//   runApp(MyApp());
// }

// HomeScreen'de kullanım:
// BlocProvider(
//   create: (context) => HomeCubit(getIt<HomeRepositoryInterface>()),
//   child: const HomeView(),
// )