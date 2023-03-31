import '/backend/api_requests/api_calls.dart';
import '/components/hotel_booking_bottom_sheet_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'hotel_maps_model.dart';
export 'hotel_maps_model.dart';

class HotelMapsWidget extends StatefulWidget {
  const HotelMapsWidget({
    Key? key,
    this.latLong,
    this.hotelName,
    this.destinationId,
    this.countriesRef,
    this.citiesRef,
    this.hotelData,
  }) : super(key: key);

  final List<LatLng>? latLong;
  final String? hotelName;
  final String? destinationId;
  final DocumentReference? countriesRef;
  final DocumentReference? citiesRef;
  final dynamic hotelData;

  @override
  _HotelMapsWidgetState createState() => _HotelMapsWidgetState();
}

class _HotelMapsWidgetState extends State<HotelMapsWidget> {
  late HotelMapsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelMapsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: GetHotelsCall.call(
        destinationId: valueOrDefault<String>(
          widget.destinationId,
          '2265',
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: SpinKitFadingCircle(
                color: FlutterFlowTheme.of(context).primary,
                size: 50.0,
              ),
            ),
          );
        }
        final hotelMapsGetHotelsResponse = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xFFEFEFEF),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primary,
            automaticallyImplyLeading: false,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).black600,
                size: 24.0,
              ),
              onPressed: () async {
                context.safePop();
              },
            ),
            title: Text(
              'Google Maps',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Lato',
                    color: FlutterFlowTheme.of(context).black600,
                    fontSize: 22.0,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 1.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x430F1113),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              context.pushNamed(
                                'Hotels',
                                queryParams: {
                                  'countryRef': serializeParam(
                                    widget.countriesRef,
                                    ParamType.DocumentReference,
                                  ),
                                  'cityRef': serializeParam(
                                    widget.citiesRef,
                                    ParamType.DocumentReference,
                                  ),
                                  'destinationId': serializeParam(
                                    widget.destinationId,
                                    ParamType.String,
                                  ),
                                  'hotelNames': serializeParam(
                                    (GetHotelsCall.jsonHotelNames(
                                      hotelMapsGetHotelsResponse.jsonBody,
                                    ) as List)
                                        .map<String>((s) => s.toString())
                                        .toList(),
                                    ParamType.String,
                                    true,
                                  ),
                                  'price': serializeParam(
                                    GetHotelsCall.jsonHotelPrice(
                                      hotelMapsGetHotelsResponse.jsonBody,
                                    ),
                                    ParamType.double,
                                    true,
                                  ),
                                  'hotelImages': serializeParam(
                                    GetHotelsCall.jsonHotelImages(
                                      hotelMapsGetHotelsResponse.jsonBody,
                                    ),
                                    ParamType.String,
                                    true,
                                  ),
                                  'ratings': serializeParam(
                                    GetHotelsCall.jsonPropertyReviews(
                                      hotelMapsGetHotelsResponse.jsonBody,
                                    ),
                                    ParamType.double,
                                    true,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            child: Text(
                              'List View',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Lato',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 1.0,
                        decoration: BoxDecoration(),
                        child: FlutterFlowGoogleMap(
                          controller: _model.googleMapsController,
                          onCameraIdle: (latLng) =>
                              setState(() => _model.googleMapsCenter = latLng),
                          initialLocation: _model.googleMapsCenter ??= functions
                              .getListLatLong(
                                  GetHotelsCall.jsonLats(
                                    hotelMapsGetHotelsResponse.jsonBody,
                                  )?.toList(),
                                  GetHotelsCall.jsonLongi(
                                    hotelMapsGetHotelsResponse.jsonBody,
                                  )?.toList())!
                              .first,
                          markers: (functions.getListLatLong(
                                      GetHotelsCall.jsonLats(
                                        hotelMapsGetHotelsResponse.jsonBody,
                                      )?.toList(),
                                      GetHotelsCall.jsonLongi(
                                        hotelMapsGetHotelsResponse.jsonBody,
                                      )?.toList()) ??
                                  [])
                              .map(
                                (marker) => FlutterFlowMarker(
                                  marker.serialize(),
                                  marker,
                                  () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.white,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                              MediaQuery.of(context).viewInsets,
                                          child: HotelBookingBottomSheetWidget(
                                            hotelName:
                                                (GetHotelsCall.jsonHotelNames(
                                              hotelMapsGetHotelsResponse
                                                  .jsonBody,
                                            ) as List)
                                                    .map<String>(
                                                        (s) => s.toString())
                                                    .toList()
                                                    .first,
                                            image:
                                                GetHotelsCall.jsonHotelImages(
                                              hotelMapsGetHotelsResponse
                                                  .jsonBody,
                                            ).first,
                                          ),
                                        );
                                      },
                                    ).then((value) => setState(() {}));
                                  },
                                ),
                              )
                              .toList(),
                          markerColor: GoogleMarkerColor.violet,
                          mapType: MapType.normal,
                          style: GoogleMapStyle.standard,
                          initialZoom: 12.0,
                          allowInteraction: true,
                          allowZoom: true,
                          showZoomControls: true,
                          showLocation: true,
                          showCompass: true,
                          showMapToolbar: true,
                          showTraffic: false,
                          centerMapOnMarkerTap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
