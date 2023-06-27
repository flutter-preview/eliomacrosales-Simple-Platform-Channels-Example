import 'dart:async';
import 'package:flutter/services.dart';

import '../../../../core/permission/permission_handler.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final PermissionHandler permissionHandler;

  final MethodChannel _methodChannel =
      const MethodChannel("implementation.channel");
  final _eventChannel = const EventChannel("geolocation.listener");
  late StreamSubscription _subscription;

  LocationRepositoryImpl({required this.permissionHandler});

  @override
  Stream<Map<String, double>> listenChangesGPS() {
    StreamController<Map<String, double>> streamController =
        StreamController<Map<String, double>>();

    permissionHandler.isPermissionGranted().then((isGranted) {
      if (isGranted) {
        _eventChannel.receiveBroadcastStream().listen((event) {
          streamController.add(event.cast<String, double>());
        });
      }
    });

    return streamController.stream;
  }

  @override
  Future<void> startLocation() async {
    await _methodChannel.invokeMethod("startLocation");
  }

  @override
  Future<void> stopLocation() async {
    await _methodChannel.invokeMethod("stopLocation");
    _subscription.cancel();
  }
}
