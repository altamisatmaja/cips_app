import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui; // Import for capturing widget images
import 'package:cips_app/ui/widgets/widget.dart';
import 'package:cips_app/utils/util.dart';
import 'package:flutter/rendering.dart'; // Import for RepaintBoundary
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:date_time/date_time.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'package:camera/camera.dart';
import 'package:cips_app/data/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

part 'start/welcome_screen.dart';
part 'capture/capture_screen.dart';
part 'configure/configure_screen.dart';
part 'auth/sign_in_screen.dart';
part 'auth/sign_up_screen.dart';
part 'home/home_screen.dart';
part 'fragment/configure_fragment.dart';
part 'fragment/home_fragment.dart';
part 'fragment/profile_fragment.dart';
