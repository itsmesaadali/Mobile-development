import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../services/api_service.dart';

class ActivityProvider with ChangeNotifier {
  List<Activity> _activities = [];

  List<Activity> get activities => _activities;

  Future<void> loadActivities() async {
    final data = await ApiService.getActivities();
    _activities = data
        .map<Activity>((json) => Activity.fromJson(json))
        .toList();
    notifyListeners();
  }

  Future<void> addActivity(Activity activity) async {
    await ApiService.createActivity(
      image: activity.image,
      location: activity.location,
    );
    await loadActivities();
  }

  Future<void> deleteActivity(String id) async {
    await ApiService.deleteActivity(id);
    await loadActivities();
  }
}
