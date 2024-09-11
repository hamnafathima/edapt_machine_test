import 'package:edapt_machine_test/model/selected_model.dart';
import 'package:edapt_machine_test/utils/api_urls.dart';
import 'package:edapt_machine_test/utils/get_service_util.dart';
import 'package:flutter/material.dart';

class SelectedProvider extends ChangeNotifier {
  bool isDataLoading = false;
  List<SelectedModel> selectedList = [];

  fetchSelectedData(BuildContext context) async {
    selectedList.clear();
    setDataLoading(true);
    try {
      final jsonData =
          await GetServiceUtils.fetchData(ApiUrls.getAllProducts(), context);
      selectedList = selectedModelFromJson(jsonData);
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
    setDataLoading(false);
  }

  setDataLoading(bool loading) {
    isDataLoading = loading;
    notifyListeners();
  }
}
