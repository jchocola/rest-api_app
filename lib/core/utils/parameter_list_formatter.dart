// ignore_for_file: dangling_library_doc_comments
import 'package:api_client/data/model/parameter_model.dart';

/// This function format the list<ParameterModel> -> Map<String,dynamic>
///  ex: input = [true - name1 - value1, false - name2 - value2, true - name3 - value3]
///      output = {name1: value1, name3: value3 }

///
/// USE THIS FUNCTION TO FILTER AND PASS PARAMETER TO REQUEST
///

Map<String, dynamic> parameterListFormatter({
  required List<ParameterModel> paramsList,
}) {
  Map<String, dynamic> map = {};

  for (var param in paramsList) {
    if (!param.isSelected) {
      continue;
    } else {
      map.addAll({param.parameter: param.value});
    }
  }

  return map;
}

List<ParameterModel> parameterListFormatter2({
  required List<ParameterModel> paramsList,
}) {
  List<ParameterModel> map = [];
  for (var param in paramsList) {
    if (!param.isSelected) {
      continue;
    } else {
      map.add(param);
    }
  }
  return map;
}

String convertListParamsToString({required List<ParameterModel> listParams}) {
  String str = """ """;
  for (var model in listParams) {
    str += model.parameter + '\t:\t' + model.value + '\n';
  }

  return str;
}
