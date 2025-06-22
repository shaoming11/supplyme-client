import 'package:supplyme_client/utils/requests.dart';
import 'package:supplyme_client/utils/vars.dart';

Future<Map<String, dynamic>> callAPI(String prompt) async {
  return getData(rootAPIDomain, "${rootAPIPath}prompt", {
    "prompt": prompt
  });
}