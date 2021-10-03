import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sibly_lustre/data/address.dart';

UserLocation userLocation = UserLocation();

class UserLocation {
  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("service");
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    print('permission');
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    print('fetching location');

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Address> getAddressFromLatLong(Position position) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placeMarks);
    Placemark place = placeMarks[0];
    return Address(
      street: place.street!,
      subLocality: place.subLocality!,
      locality: place.locality!,
      postalCode: place.postalCode!,
      country: place.country!,
    );
  }
}

// class UserLocation {
//   Location location = Location();
//   late bool _serviceEnabled;
//   late PermissionStatus _permissionGranted;
//
//   // late double longitude;
//   // late double latitude;
//
//   Future<bool> isServiceEnabled() async {
//     print("service");
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return false;
//       }
//     }
//     return _serviceEnabled;
//   }
//
//   Future<PermissionStatus> hasPermission() async {
//     print('permission');
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return PermissionStatus.denied;
//       }
//     }
//     return _permissionGranted;
//   }
//
//   Future<LocationData> getLocationData() async {
//     print('fetching location');
//     return await location.getLocation();
//     // longitude = _locationData.longitude!;
//     // latitude = _locationData.latitude!;
//   }
// }
