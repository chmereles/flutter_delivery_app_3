import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AppDataSource {
  Future<void> saveDeliveryAddress({
    required String address,
    required String tagString,
  });

  Future<Map<String, dynamic>?> getHomeDeliveryAddress();
  Future<Map<String, dynamic>?> getWorkDeliveryAddress();
  Future<Map<String, dynamic>?> getOtherDeliveryAddress();
}

class AppDataSourceLocalImpl implements AppDataSource {
  @override
  Future<void> saveDeliveryAddress({
    required String address,
    required String tagString,
  }) async {
    //
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${tagString}DeliveryAdress', address);
  }

  @override
  Future<Map<String, dynamic>?> getHomeDeliveryAddress() {
    return _getAddress('Tag.home');
  }

  @override
  Future<Map<String, dynamic>?> getOtherDeliveryAddress() {
    return _getAddress('Tag.other');
  }

  @override
  Future<Map<String, dynamic>?> getWorkDeliveryAddress() {
    return _getAddress('Tag.work');
  }

  Future<Map<String, dynamic>?> _getAddress(String tagString) async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 1000));

    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('${tagString}DeliveryAdress');
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
  }
}
