
import 'package:get_it/get_it.dart';
import 'package:library_management/data/database_service/member_database_service.dart';
import 'package:library_management/data/database_service/book_database_service.dart';
import 'package:library_management/logic/database_management_service/member_management_service.dart';
import 'package:library_management/logic/database_management_service/book_management_service.dart';
import 'package:library_management/logic/database_management_service/user_management_service.dart';

import '../data/database_service/user_database_service.dart';
import 'app_management_service/firestore_service.dart';
import 'app_management_service/hive_service.dart';
import 'app_management_service/navigation_service.dart';
import 'app_management_service/startup_service.dart';


class Locator {
  static void setup() {
    GetIt.instance.registerLazySingleton(() => StartupService());
    GetIt.instance.registerLazySingleton(() => HiveService());
    GetIt.instance.registerLazySingleton(() => FirestoreService());
    GetIt.instance.registerLazySingleton(() => NavigationService());
    
     
     GetIt.instance.registerLazySingleton(() => UserDatabaseService());
    GetIt.instance.registerLazySingleton(() => MemberDatabaseService());
    
    GetIt.instance.registerLazySingleton(() => BookDatabaseService());
    // GetIt.instance.registerLazySingleton(() => StyleDatabaseService());
    //  GetIt.instance.registerLazySingleton(() => TrashDatabaseService());

    //DataManagementServices
    GetIt.instance.registerLazySingleton(() => MemberManagementService());
    GetIt.instance.registerLazySingleton(() => BookManagementService());
    // GetIt.instance.registerLazySingleton(() => StyleManagementService());
    GetIt.instance.registerLazySingleton(() => UserManagementService());
    // GetIt.instance.registerLazySingleton(() => TrashManagemenrService());
  }

  //Support Services
  static StartupService get startupService => GetIt.I<StartupService>();
  static HiveService get hiveService => GetIt.I<HiveService>();
  static FirestoreService get firestoreService => GetIt.I<FirestoreService>();
  static NavigationService get navigationService =>
      GetIt.I<NavigationService>();
  static UserDatabaseService get userDatabaseService =>
      GetIt.I<UserDatabaseService>();
  static MemberDatabaseService get memberDatabaseService =>
      GetIt.I<MemberDatabaseService>();
 
  static BookDatabaseService get bookDatabaseService =>
      GetIt.I<BookDatabaseService>();
  // static TrashDatabaseService get trashDatabaseService =>
  //     GetIt.I<TrashDatabaseService>();
  

  // //DataManagementServices
  static MemberManagementService get memberManagementService =>
      GetIt.I<MemberManagementService>();

  static BookManagementService get bookManagementService =>
      GetIt.I<BookManagementService>();
  static UserManagementService get userManagementService =>
      GetIt.I<UserManagementService>();
  // static TrashManagemenrService get trashManagemenrService =>
  //     GetIt.I<TrashManagemenrService>();
}
