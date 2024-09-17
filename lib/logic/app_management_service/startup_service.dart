import '../locator.dart';

class StartupService{
  init() async{
    await Locator.hiveService.init();
    await Locator.firestoreService.init();
    await setupApplicationData();
    await Locator.userManagementService.init();
  
     await Locator.bookManagementService.init();
    //  await Locator.styleManagementService.init();
     await Locator.memberManagementService.init();
    //  await Locator.fabricManagementService.init();

     // await Locator.trashManagemenrService.init();
  }
  
  setupApplicationData() async{
    //   if (Locator.hiveService.userBox!.isNotEmpty) {
    //   var userModel = await Locator.userDatabaseService.readUserFromLocal();
    //   Locator.userManagementService.userData.value = userModel!;
    //   // await syncCustomerData();
    //   // await syncOrderData();
    //   // await syncStyleData();
    //   // await synFabricData();
    //  // await syncTrashData();
    // } 
    try {
      final hiveBox = Locator.hiveService.userBox;
      if (hiveBox != null && hiveBox.isNotEmpty) {
        var userModel = await Locator.userDatabaseService.readUserFromLocal();
        if (userModel != null) {
          Locator.userManagementService.userData.value = userModel;
          // Uncomment and implement sync methods if needed
          await syncMemberData();
          await syncBookData();
          // await syncStyleData();
          // await synFabricData();
          // await syncTrashData();
        } else {
          print('User model is null');
        }
      } else {
        print('Hive box is empty or null');
      }
    } catch (e) {
      print('Error setting up application data: $e');
    }
  

}

 syncMemberData() async {
    if (Locator.userManagementService.userData.value != null 
) {
      var localLastModified =
          Locator.memberDatabaseService.getLocalDbLastModified();
      var remoteLastModified =
          await Locator.memberDatabaseService.getRemoteDbLastModified();
      if (localLastModified != null) {
        if (remoteLastModified.isAfter(localLastModified)) {
          await Locator.memberDatabaseService.fetchMembers(localLastModified);
        }
        var localLastModifiedAfterFetch =
            Locator.memberDatabaseService.getLocalDbLastModified();
        Locator.memberDatabaseService
            .streamRemoteToLocal(localLastModifiedAfterFetch!);
      }}
    
  }

  syncBookData() async {
    if (Locator.userManagementService.userData.value != null ) {
      var localLastModified =
          Locator.bookDatabaseService.getLocalDbLastModified();
      var remoteLastModified =
          await Locator.bookDatabaseService.getRemoteDbLastModified();
      if (localLastModified != null) {
        if (remoteLastModified.isAfter(localLastModified)) {
          await Locator.bookDatabaseService.fetchBooks(localLastModified);
        }
        var localLastModifiedAfterFetch =
            Locator.bookDatabaseService.getLocalDbLastModified();
        Locator.bookDatabaseService
            .streamRemoteToLocal(localLastModifiedAfterFetch!);
      
    }}
  }

//   syncStyleData() async {
//     if (Locator.userManagementService.userData.value != null 
// ) {
//       var localLastModified =
//           Locator.styleDatabaseService.getLocalDbLastModified();
//       var remoteLastModified =
//           await Locator.styleDatabaseService.getRemoteDbLastModified();
//       if (localLastModified != null) {
//         if (remoteLastModified.isAfter(localLastModified)) {
//           await Locator.styleDatabaseService.fetchStyle(localLastModified);
//         }
//         var localLastModifiedAfterFetch =
//             Locator.styleDatabaseService.getLocalDbLastModified();
//         Locator.styleDatabaseService
//             .streamRemoteToLocal(localLastModifiedAfterFetch!);
//       }}
    
//   }
// synFabricData() async {
//     if (Locator.userManagementService.userData.value != null 
// ) {
//       var localLastModified =
//           Locator.fabricDatabaseService.getLocalDbLastModified();
//       var remoteLastModified =
//           await Locator.fabricDatabaseService.getRemoteDbLastModified();
//       if (localLastModified != null) {
//         if (remoteLastModified.isAfter(localLastModified)) {
//           await Locator.fabricDatabaseService.fetchFabrics(localLastModified);
//         }
//         var localLastModifiedAfterFetch =
//             Locator.fabricDatabaseService.getLocalDbLastModified();
//         Locator.fabricDatabaseService
//             .streamRemoteToLocal(localLastModifiedAfterFetch!);
//       }}
    
//   }
  // syncTrashData() async {
  //   if (Locator.userManagementService.userData.value != null ) {
  //     var localLastModified =
  //         Locator.trashDatabaseService.getLocalDbLastModified();
  //     var remoteLastModified =
  //         await Locator.trashDatabaseService.getRemoteDbLastModified();
  //     if (localLastModified != null) {
  //       if (remoteLastModified.isAfter(localLastModified)) {
  //         await Locator.trashDatabaseService.fetchTrashs(localLastModified);
  //       }
  //       var localLastModifiedAfterFetch =
  //           Locator.trashDatabaseService.getLocalDbLastModified();
  //       Locator.trashDatabaseService
  //           .streamRemoteToLocal(localLastModifiedAfterFetch!);
  //     }
  //   }
  // }


}