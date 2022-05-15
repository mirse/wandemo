import 'package:permission_handler/permission_handler.dart';

typedef Denied();
typedef PermanentlyDenied();
typedef Granted();

class PermissionUtils{
  static Future requestPermission(Permission permission,{required Denied denied,required PermanentlyDenied permanentlyDenied,required Granted granted}) async {
    PermissionStatus permissionStatus = await permission.request();
    switch(permissionStatus){
      case PermissionStatus.granted:
        granted();
        break;
      case PermissionStatus.denied:
        denied();
        break;
      case PermissionStatus.permanentlyDenied:////拒绝，且不在提示
        permanentlyDenied();
        break;
      default:
        break;
    }
  }
}