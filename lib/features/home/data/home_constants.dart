import 'package:soul_trip/core/models/category_model.dart';
import 'package:soul_trip/core/theme/soultrip_icons.dart';

class HomeConstants {
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', name: 'Spa & Wellness', icon: Soultrip.spaRounded),
    CategoryModel(id: '2', name: 'Photography', icon: Soultrip.photoPlusSolid),
    CategoryModel(id: '3', name: 'Meditation', icon: Soultrip.mdiMeditation),
    CategoryModel(id: '4', name: 'Nature', icon: Soultrip.plant),
    CategoryModel(id: '5', name: 'Fitness', icon: Soultrip.fitnessFill),
  ];
}
