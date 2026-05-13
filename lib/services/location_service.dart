import 'dart:math' as math;
import 'package:geolocator/geolocator.dart';

/// Represents a user's resolved location: GPS coordinates plus a human-
/// readable label like "London, UK". The label is computed from a small
/// city lookup table for speed and predictability; a full reverse-geocoding
/// service (e.g. Mapbox or Nominatim) can be wired in later if needed.
class UserLocation {
  final double latitude;
  final double longitude;
  final String cityName;
  final bool isFallback;

  const UserLocation({
    required this.latitude,
    required this.longitude,
    required this.cityName,
    this.isFallback = false,
  });

  Map<String, dynamic> toMap() => {
        'latitude': latitude,
        'longitude': longitude,
        'cityName': cityName,
        'isFallback': isFallback,
      };

  @override
  String toString() => '$cityName (${latitude.toStringAsFixed(3)}, '
      '${longitude.toStringAsFixed(3)})';
}

/// LocationService handles GPS permission, position acquisition, and the
/// mapping from coordinates to a city name. The class is designed to fail
/// gracefully: if permission is denied or GPS is unavailable, it returns
/// a London fallback so the rest of the app keeps working.
class LocationService {
  /// London fallback used when GPS is unavailable or denied. Keeps the
  /// app functional for the coursework demo even on emulators without
  /// a configured fake GPS.
  static const _fallback = UserLocation(
    latitude: 51.5074,
    longitude: -0.1278,
    cityName: 'London, UK',
    isFallback: true,
  );

  /// A short list of well-known cities used to give a friendly name to a
  /// GPS reading. For coursework purposes this avoids a third reverse-
  /// geocoding API call; a production app would swap this for Mapbox or
  /// Nominatim. Each entry: name, lat, lng, radiusKm.
  static const _knownCities = <_KnownCity>[
    _KnownCity('London, UK', 51.5074, -0.1278, 40),
    _KnownCity('Paris, FR', 48.8566, 2.3522, 30),
    _KnownCity('New York, US', 40.7128, -74.0060, 40),
    _KnownCity('Berlin, DE', 52.5200, 13.4050, 30),
    _KnownCity('Madrid, ES', 40.4168, -3.7038, 30),
    _KnownCity('Rome, IT', 41.9028, 12.4964, 30),
    _KnownCity('Lisbon, PT', 38.7223, -9.1393, 25),
    _KnownCity('Dubai, AE', 25.2048, 55.2708, 40),
    _KnownCity('Singapore, SG', 1.3521, 103.8198, 30),
    _KnownCity('Tokyo, JP', 35.6762, 139.6503, 50),
    _KnownCity('Sydney, AU', -33.8688, 151.2093, 40),
    _KnownCity('Nairobi, KE', -1.2921, 36.8219, 30),
    _KnownCity('Lagos, NG', 6.5244, 3.3792, 30),
    _KnownCity('Cape Town, ZA', -33.9249, 18.4241, 30),
  ];

  /// Returns the current user location, or a fallback if GPS isn't
  /// available. Always succeeds - callers don't need to handle errors.
  Future<UserLocation> getCurrentLocation() async {
    try {
      // Check whether location services are enabled on the device.
      final servicesEnabled = await Geolocator.isLocationServiceEnabled();
      if (!servicesEnabled) return _fallback;

      // Ask for permission if needed.
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return _fallback;
      }
      if (permission == LocationPermission.deniedForever) return _fallback;

      // Get the position. We use medium accuracy because tomato growing
      // advice doesn't need 1-metre precision and lower accuracy is
      // faster and uses less battery.
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return UserLocation(
        latitude: pos.latitude,
        longitude: pos.longitude,
        cityName: _nearestCityName(pos.latitude, pos.longitude),
      );
    } catch (_) {
      // Any failure - permission errors, timeouts, plugin issues - falls
      // back to London so the app stays usable.
      return _fallback;
    }
  }

  /// Returns the fallback location without attempting GPS. Useful for
  /// previews or when the user explicitly chooses a city.
  UserLocation get fallback => _fallback;

  /// Finds the nearest known city within its radius, or returns a
  /// "near {lat}, {lng}" string if none match.
  String _nearestCityName(double lat, double lng) {
    _KnownCity? best;
    double bestDistanceKm = double.infinity;
    for (final city in _knownCities) {
      final dKm = _haversineKm(lat, lng, city.lat, city.lng);
      if (dKm <= city.radiusKm && dKm < bestDistanceKm) {
        best = city;
        bestDistanceKm = dKm;
      }
    }
    if (best != null) return best.name;
    return 'near ${lat.toStringAsFixed(2)}, ${lng.toStringAsFixed(2)}';
  }

  /// Haversine great-circle distance in kilometres between two points.
  double _haversineKm(double lat1, double lng1, double lat2, double lng2) {
    const earthRadiusKm = 6371.0;
    final dLat = _toRadians(lat2 - lat1);
    final dLng = _toRadians(lng2 - lng1);
    final sinHalfLat = math.sin(dLat / 2);
    final sinHalfLng = math.sin(dLng / 2);
    final a = sinHalfLat * sinHalfLat +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            sinHalfLng *
            sinHalfLng;
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _toRadians(double deg) => deg * math.pi / 180.0;
}

class _KnownCity {
  const _KnownCity(this.name, this.lat, this.lng, this.radiusKm);
  final String name;
  final double lat;
  final double lng;
  final double radiusKm;
}