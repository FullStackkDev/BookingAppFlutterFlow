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
  "resultsSize": 5,
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
        'X-RapidAPI-Key': '9328d0d100msh18a2f8d01ee5ae8p133331jsn679212324536',
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

  static dynamic jsonLats(dynamic response) => getJsonField(
        response,
        r'''$.data.propertySearch.properties[:].mapMarker.latLong.latitude''',
        true,
      );
  static dynamic jsonLongi(dynamic response) => getJsonField(
        response,
        r'''$.data.propertySearch.properties[:].mapMarker.latLong.longitude''',
        true,
      );
  static dynamic jsonHotelNames(dynamic response) => getJsonField(
        response,
        r'''$.data.propertySearch.properties[:].name''',
        true,
      );
  static dynamic jsonHotelPrice(dynamic response) => getJsonField(
        response,
        r'''$.data.propertySearch.properties[:].price.lead.amount''',
        true,
      );
  static dynamic jsonHotelImages(dynamic response) => getJsonField(
        response,
        r'''$.data.propertySearch.properties[:].propertyImage.image.url''',
        true,
      );
  static dynamic jsonPropertyReviews(dynamic response) => getJsonField(
        response,
        r'''$.data.propertySearch.properties[:].reviews.score''',
        true,
      );
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
