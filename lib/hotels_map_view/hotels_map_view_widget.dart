import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'hotels_map_view_model.dart';
export 'hotels_map_view_model.dart';

class HotelsMapViewWidget extends StatefulWidget {
  const HotelsMapViewWidget({
    Key? key,
    this.destinationId,
    this.countryRef,
    this.cityRef,
  }) : super(key: key);

  final String? destinationId;
  final DocumentReference? countryRef;
  final DocumentReference? cityRef;

  @override
  _HotelsMapViewWidgetState createState() => _HotelsMapViewWidgetState();
}

class _HotelsMapViewWidgetState extends State<HotelsMapViewWidget>
    with TickerProviderStateMixin {
  late HotelsMapViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelsMapViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
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
        final hotelsMapViewGetHotelsResponse = snapshot.data!;
        return Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
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
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            title: Text(
              'Hotels',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Lato',
                    color: FlutterFlowTheme.of(context).black600,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            actions: [],
            centerTitle: true,
            elevation: 2.0,
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: FlutterFlowTheme.of(context).primary,
                          unselectedLabelColor:
                              FlutterFlowTheme.of(context).accent1,
                          labelStyle: FlutterFlowTheme.of(context).titleMedium,
                          indicatorColor: FlutterFlowTheme.of(context).primary,
                          indicatorWeight: 2.0,
                          tabs: [
                            Tab(
                              text: 'Map View',
                            ),
                            Tab(
                              text: 'List View',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              KeepAliveWidgetWrapper(
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  1.0,
                                              decoration: BoxDecoration(),
                                              child: FlutterFlowGoogleMap(
                                                controller:
                                                    _model.googleMapsController,
                                                onCameraIdle: (latLng) =>
                                                    setState(() => _model
                                                            .googleMapsCenter =
                                                        latLng),
                                                initialLocation:
                                                    _model.googleMapsCenter ??=
                                                        functions
                                                            .getListLatLong(
                                                                GetHotelsCall
                                                                    .jsonLats(
                                                                  hotelsMapViewGetHotelsResponse
                                                                      .jsonBody,
                                                                )?.toList(),
                                                                GetHotelsCall
                                                                    .jsonLongi(
                                                                  hotelsMapViewGetHotelsResponse
                                                                      .jsonBody,
                                                                )?.toList())!
                                                            .first,
                                                markers:
                                                    (functions.getListLatLong(
                                                                GetHotelsCall
                                                                    .jsonLats(
                                                                  hotelsMapViewGetHotelsResponse
                                                                      .jsonBody,
                                                                )?.toList(),
                                                                GetHotelsCall
                                                                    .jsonLongi(
                                                                  hotelsMapViewGetHotelsResponse
                                                                      .jsonBody,
                                                                )?.toList()) ??
                                                            [])
                                                        .map(
                                                          (marker) =>
                                                              FlutterFlowMarker(
                                                            marker.serialize(),
                                                            marker,
                                                          ),
                                                        )
                                                        .toList(),
                                                markerColor:
                                                    GoogleMarkerColor.violet,
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
                              ),
                              KeepAliveWidgetWrapper(
                                builder: (context) => SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 44.0),
                                        child: Builder(
                                          builder: (context) {
                                            final items = getJsonField(
                                              hotelsMapViewGetHotelsResponse
                                                  .jsonBody,
                                              r'''$.data.propertySearch.properties''',
                                            ).toList().take(5).toList();
                                            if (items.isEmpty) {
                                              return Image.network(
                                                'https://i.pinimg.com/originals/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.png',
                                              );
                                            }
                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: items.length,
                                              itemBuilder:
                                                  (context, itemsIndex) {
                                                final itemsItem =
                                                    items[itemsIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 0.0, 16.0,
                                                          12.0),
                                                  child: InkWell(
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        'ConfirmBooking',
                                                        queryParams: {
                                                          'countryRef':
                                                              serializeParam(
                                                            widget.countryRef,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'cityRef':
                                                              serializeParam(
                                                            widget.cityRef,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                          'name':
                                                              serializeParam(
                                                            getJsonField(
                                                              itemsItem,
                                                              r'''$.name''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'ratings':
                                                              serializeParam(
                                                            getJsonField(
                                                              itemsItem,
                                                              r'''$.reviews.score''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'image':
                                                              serializeParam(
                                                            getJsonField(
                                                              itemsItem,
                                                              r'''$.propertyImage.image.url''',
                                                            ),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: 100.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .lineColor,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 5.0,
                                                            color: Color(
                                                                0x1F000000),
                                                            offset: Offset(
                                                                0.0, 2.0),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      0.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      12.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12.0),
                                                            ),
                                                            child:
                                                                Image.network(
                                                              getJsonField(
                                                                itemsItem,
                                                                r'''$.propertyImage.image.url''',
                                                              ),
                                                              width: double
                                                                  .infinity,
                                                              height: 240.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        12.0,
                                                                        16.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    getJsonField(
                                                                      itemsItem,
                                                                      r'''$.name''',
                                                                    ).toString(),
                                                                    maxLines: 1,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodySmall
                                                                        .override(
                                                                          fontFamily:
                                                                              'Lato',
                                                                          fontSize:
                                                                              14.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        16.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Ratings: ',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                                Text(
                                                                  getJsonField(
                                                                    itemsItem,
                                                                    r'''$.reviews.score''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium,
                                                                ),
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        '\$ ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        getJsonField(
                                                                          itemsItem,
                                                                          r'''$.price.lead.amount''',
                                                                        ).toString().maybeHandleOverflow(
                                                                            maxChars:
                                                                                6),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              fontFamily: 'Lato',
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
