import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetHotelsCall {
  static Future<ApiCallResponse> call({
    String? destinationId = '',
  }) {
    final body = '''
{
  "currency": "USD",
  "destination": {
    "regionId": "${destinationId}"
  },
  "checkInDate": {
    "day": 10,
    "month": 10,
    "year": 2022
  },
  "checkOutDate": {
    "day": 15,
    "month": 10,
    "year": 2022
  },
  "rooms": [
    {
      "adults": 2
    }
  ],
  "resultsStartingIndex": 0,
  "resultsSize": 200,
  "sort": "PRICE_LOW_TO_HIGH",
  "filters": {
    "price": {
      "max": 150,
      "min": 100
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getHotels',
      apiUrl: 'https://hotels4.p.rapidapi.com/properties/v2/list',
      callType: ApiCallType.POST,
      headers: {
        'X-RapidAPI-Key': 'c5d2a55b8dmsh46b11090f56f370p1ef98ajsn37fc164bd6dd',
        'X-RapidAPI-Host': 'hotels4.p.rapidapi.com',
      },
      params: {},
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
