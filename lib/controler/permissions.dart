import 'package:simple_permissions/simple_permissions.dart';

class CheckPermissionsApp {
  Permission permission = Permission.AccessCoarseLocation;

  //Checar a permissão de localização
  requestPermission() async {
    final res = await SimplePermissions.requestPermission(permission);
    print("permission request result is " + res.toString());
    if(res != PermissionStatus.authorized)
      checkPermission();
  }

  checkPermission() async {
    bool res = await SimplePermissions.checkPermission(permission);
    print("permission is " + res.toString());
  }
}