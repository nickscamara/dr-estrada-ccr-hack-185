import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createCustomMarkerBitmap(String title) async {
        TextSpan span = new TextSpan(
          style: new TextStyle(
            color:Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
          text: title,
        );

        TextPainter tp = new TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        PictureRecorder recorder = new PictureRecorder();
        Canvas c = new Canvas(recorder);

        tp.layout();
        tp.paint(c, new Offset(20.0, 10.0));

        /* Do your painting of the custom icon here, including drawing text, shapes, etc. */

        Picture p = recorder.endRecording();
        ByteData pngBytes =
            await (await p.toImage(tp.width.toInt() + 40, tp.height.toInt() + 20))
                .toByteData(format: ImageByteFormat.png);

        Uint8List data = Uint8List.view(pngBytes.buffer);

        return BitmapDescriptor.fromBytes(data);
      }