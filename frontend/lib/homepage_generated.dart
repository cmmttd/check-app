import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            'Page Title',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 0,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 421,
                height: 734,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        width: 381,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x33000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(16, 0, 0, 8),
                                child: Text(
                                  'Select User',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 16,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: Color(0xFFE0E3E7),
                              ),
                              ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  MouseRegion(
                                    opaque: false,
                                    cursor:
                                    MouseCursor.defer ?? MouseCursor.defer,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 150),
                                      curve: Curves.easeInOut,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: _model.iuserHovered1!
                                            ? Color(0xFFF1F4F8)
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 12, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(40),
                                                child: Image.network(
                                                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnN8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                                  width: 32,
                                                  height: 32,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Randy Peterson',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF14181B),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      'name@domainname.com',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodySmall
                                                          .override(
                                                        fontFamily:
                                                        'Plus Jakarta Sans',
                                                        color: Color(
                                                            0xFF4B39EF),
                                                        fontSize: 12,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                        FontWeight.w500,
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
                                    onEnter: ((event) async {
                                      setState(
                                              () => _model.iuserHovered1 = true);
                                    }),
                                    onExit: ((event) async {
                                      setState(
                                              () => _model.iuserHovered1 = false);
                                    }),
                                  ),
                                  MouseRegion(
                                    opaque: false,
                                    cursor:
                                    MouseCursor.defer ?? MouseCursor.defer,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 150),
                                      curve: Curves.easeInOut,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: _model.iuserHovered2!
                                            ? Color(0xFFF1F4F8)
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 12, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(40),
                                                child: Image.network(
                                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=900&q=60',
                                                  width: 32,
                                                  height: 32,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Randy Peterson',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF14181B),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      'name@domainname.com',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodySmall
                                                          .override(
                                                        fontFamily:
                                                        'Plus Jakarta Sans',
                                                        color: Color(
                                                            0xFF4B39EF),
                                                        fontSize: 12,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                        FontWeight.w500,
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
                                    onEnter: ((event) async {
                                      setState(
                                              () => _model.iuserHovered2 = true);
                                    }),
                                    onExit: ((event) async {
                                      setState(
                                              () => _model.iuserHovered2 = false);
                                    }),
                                  ),
                                  MouseRegion(
                                    opaque: false,
                                    cursor:
                                    MouseCursor.defer ?? MouseCursor.defer,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 150),
                                      curve: Curves.easeInOut,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: _model.iuserHovered3!
                                            ? Color(0xFFF1F4F8)
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 12, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(40),
                                                child: Image.network(
                                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60',
                                                  width: 32,
                                                  height: 32,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Randy Peterson',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF14181B),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      'name@domainname.com',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodySmall
                                                          .override(
                                                        fontFamily:
                                                        'Plus Jakarta Sans',
                                                        color: Color(
                                                            0xFF4B39EF),
                                                        fontSize: 12,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                        FontWeight.w500,
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
                                    onEnter: ((event) async {
                                      setState(
                                              () => _model.iuserHovered3 = true);
                                    }),
                                    onExit: ((event) async {
                                      setState(
                                              () => _model.iuserHovered3 = false);
                                    }),
                                  ),
                                  MouseRegion(
                                    opaque: false,
                                    cursor:
                                    MouseCursor.defer ?? MouseCursor.defer,
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 150),
                                      curve: Curves.easeInOut,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: _model.iuserHovered4!
                                            ? Color(0xFFF1F4F8)
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 8, 12, 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 8, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(40),
                                                child: Image.network(
                                                  'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjF8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60',
                                                  width: 32,
                                                  height: 32,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(4, 0, 0, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Randy Peterson',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .bodyMedium
                                                        .override(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      color:
                                                      Color(0xFF14181B),
                                                      fontSize: 14,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      'name@domainname.com',
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodySmall
                                                          .override(
                                                        fontFamily:
                                                        'Plus Jakarta Sans',
                                                        color: Color(
                                                            0xFF4B39EF),
                                                        fontSize: 12,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                        FontWeight.w500,
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
                                    onEnter: ((event) async {
                                      setState(
                                              () => _model.iuserHovered4 = true);
                                    }),
                                    onExit: ((event) async {
                                      setState(
                                              () => _model.iuserHovered4 = false);
                                    }),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Color(0xFFE0E3E7),
                              ),
                              MouseRegion(
                                opaque: false,
                                cursor: SystemMouseCursors.click ??
                                    MouseCursor.defer,
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  curve: Curves.easeInOut,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: _model.mouseRegionHovered!
                                        ? Color(0xFFF1F4F8)
                                        : Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                          child: Icon(
                                            Icons.person_add_rounded,
                                            color: Color(0xFF14181B),
                                            size: 20,
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                12, 0, 12, 0),
                                            child: Text(
                                              'Add User',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily:
                                                'Plus Jakarta Sans',
                                                color: Color(0xFF14181B),
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onEnter: ((event) async {
                                  setState(
                                          () => _model.mouseRegionHovered = true);
                                }),
                                onExit: ((event) async {
                                  setState(
                                          () => _model.mouseRegionHovered = false);
                                }),
                              ),
                            ],
                          ),
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
    );
  }
}
