

import 'package:mynewpackage/app/modules/history/data/models/cab_history_response.dart';

abstract class HistoryService {
  Future<CabHistoryResponse> getRideHistory({required String filter,required String userId,required int page,required int limit});
}
