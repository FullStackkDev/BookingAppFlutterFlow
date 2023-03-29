import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'hotels_model.dart';
export 'hotels_model.dart';

class HotelsWidget extends StatefulWidget {
  const HotelsWidget({
    Key? key,
    this.countryRef,
    this.cityRef,
    this.destinationId,
  }) : super(key: key);

  final DocumentReference? countryRef;
  final DocumentReference? cityRef;
  final String? destinationId;

  @override
  _HotelsWidgetState createState() => _HotelsWidgetState();
}

class _HotelsWidgetState extends State<HotelsWidget>
    with TickerProviderStateMixin {
  late HotelsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HotelsModel());
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
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
            context.pop();
          },
        ),
        title: Text(
          'Hotels',
          style: FlutterFlowTheme.of(context).title1.override(
                fontFamily: 'Lato',
                color: FlutterFlowTheme.of(context).black600,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 44.0),
                  child: FutureBuilder<ApiCallResponse>(
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
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 50.0,
                            ),
                          ),
                        );
                      }
                      final listViewGetHotelsResponse = snapshot.data!;
                      return Builder(
                        builder: (context) {
                          final items = getJsonField(
                            listViewGetHotelsResponse.jsonBody,
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
                            itemBuilder: (context, itemsIndex) {
                              final itemsItem = items[itemsIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 12.0),
                                child: InkWell(
                                  onTap: () async {
                                    context.pushNamed(
                                      'ConfirmBooking',
                                      queryParams: {
                                        'name': serializeParam(
                                          getJsonField(
                                            itemsItem,
                                            r'''$.name''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                        'ratings': serializeParam(
                                          getJsonField(
                                            itemsItem,
                                            r'''$.reviews.score''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                        'image': serializeParam(
                                          getJsonField(
                                            itemsItem,
                                            r'''$.propertyImage.image.url''',
                                          ),
                                          ParamType.String,
                                        ),
                                        'countryRef': serializeParam(
                                          widget.countryRef,
                                          ParamType.DocumentReference,
                                        ),
                                        'cityRef': serializeParam(
                                          widget.cityRef,
                                          ParamType.DocumentReference,
                                        ),
                                        'cityName': serializeParam(
                                          widget.cityRef?.id,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Container(
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5.0,
                                          color: Color(0x1F000000),
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(0.0),
                                            topLeft: Radius.circular(12.0),
                                            topRight: Radius.circular(12.0),
                                          ),
                                          child: Image.network(
                                            getJsonField(
                                              itemsItem,
                                              r'''$.propertyImage.image.url''',
                                            ),
                                            width: double.infinity,
                                            height: 240.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 12.0, 16.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 5.0, 0.0),
                                                child: Text(
                                                  getJsonField(
                                                    itemsItem,
                                                    r'''$.name''',
                                                  )
                                                      .toString()
                                                      .maybeHandleOverflow(
                                                          maxChars: 22),
                                                  maxLines: 1,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText2
                                                      .override(
                                                        fontFamily: 'Lato',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    '\$ ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                5.0, 0.0),
                                                    child: Text(
                                                      getJsonField(
                                                        itemsItem,
                                                        r'''$.price.lead.amount''',
                                                      )
                                                          .toString()
                                                          .maybeHandleOverflow(
                                                              maxChars: 6),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle1
                                                              .override(
                                                                fontFamily:
                                                                    'Lato',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 16.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Ratings:  ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1,
                                              ),
                                              Text(
                                                getJsonField(
                                                  itemsItem,
                                                  r'''$.reviews.score''',
                                                ).toString(),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2,
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  context.pushNamed(
                                                    'HotelMaps',
                                                    queryParams: {
                                                      'latLong': serializeParam(
                                                        functions.getLatLong(
                                                            getJsonField(
                                                              itemsItem,
                                                              r'''$.mapMarker.latLong.latitude''',
                                                            ),
                                                            getJsonField(
                                                              itemsItem,
                                                              r'''$.mapMarker.latLong.longitude''',
                                                            )),
                                                        ParamType.LatLng,
                                                      ),
                                                      'hotelName':
                                                          serializeParam(
                                                        getJsonField(
                                                          itemsItem,
                                                          r'''$.name''',
                                                        ).toString(),
                                                        ParamType.String,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                },
                                                text: 'View on Map',
                                                options: FFButtonOptions(
                                                  width: 120.0,
                                                  height: 25.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryColor,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2
                                                          .override(
                                                            fontFamily: 'Lato',
                                                            color: Colors.white,
                                                          ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
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
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
